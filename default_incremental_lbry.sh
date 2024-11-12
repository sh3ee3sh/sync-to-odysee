#!/bin/bash

# Configuration
LBRY_CLI="/usr/bin/lbrynet"  # Path to lbrynet CLI
UPLOAD_DIR=""    # Path to the directory containing the files to upload
PUBLISHED_FILE=".published_videos"   # Hidden file to store the list of already uploaded files
CHANNELID=""              # find it on your about page on odysee
WALLETID="default_wallet" # first login should be with your odysee account to get this value
BID_AMOUNT=0.001                     # absolute minimum bid amount 
# Ensure the published file exists
if [ ! -f "$UPLOAD_DIR/$PUBLISHED_FILE" ]; then
    touch "$UPLOAD_DIR/$PUBLISHED_FILE"
fi

claim_id_log="$UPLOAD_DIR/claim_ids.txt"
if [ ! -f "$claim_id_log" ]; then 
  touch "$claim_id_log"
fi

# Function to check if a file is already uploaded
is_uploaded() {
    local file=$1
    grep -Fxq "$file" "$UPLOAD_DIR/$PUBLISHED_FILE"
}

# find and upload only .mp4 files to lbry
find "$UPLOAD_DIR" -type f -name "*.mp4" | while read -r file; do
    filename=$(basename "$file")  # get the base filename
    dir_name=$(dirname "$file")   # get the directory of the file
    clean_name=$(echo "${filename%.mp4}" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9-')  # clean the filename
    title=${filename%.mp4}
    if [[ "${filename%.mp4}" != "$clean_name" ]]; then
      # create a random string due to lack of characters; I had an issue with japanese characters and it would keep overwriting claims i had because it didn't recognize it.
      randomstring=$(cat /dev/urandom | tr -cd 'a-zA-Z0-9'| head -c 20)
      clean_name="${clean_name}${randomstring}"
    fi

    # Check if the file has already been uploaded
    if ! is_uploaded "$filename"; then
        echo "Uploading $filename..."

        # Check if the directory contains a tags.txt file
        tags_file="$dir_name/tags.txt"
        if [ -f "$tags_file" ]; then
            tags=$(for tag in $(cat "$tags_file"); do echo "--tags=$tag"; done)
        else
            tags=""  # No tags if no tags.txt is found
        fi

        # Check if the directory contains a thumbnail.jpg file
       thumbnail_file="$dir_name/thumbnail-url.txt"
        if [ -f "$thumbnail_file" ]; then
            thumbnail_url=$(cat "$thumbnail_file")  # Read the thumbnail URL from the file
        else
            thumbnail_url=""  # No thumbnail URL if no thumbnail-url.txt is found
        fi
        # Check if the directory contains a video.description file
        description_file="$dir_name/video.description"
        if [ -f "$description_file" ]; then
            DESCRIPTION=$(cat "$description_file")  # Read the description from the file
        else
            DESCRIPTION="No description available."  # Default description if none is found
        fi

        # Upload file to LBRY with the given options
        output=$($LBRY_CLI publish "$clean_name" \
            --file_path="$file" \
            $tags \
            --bid="$BID_AMOUNT" \
            --title="$title" \
            --description="$DESCRIPTION" \
            --channel_id="$CHANNELID" \
            --wallet_id="$WALLETID" \
            ${thumbnail_url:+--thumbnail_url="$thumbnail_url"})  # Only include if thumbnail_url is set
            # Check if upload was successful
        if [ $? -eq 0 ]; then
            echo "$filename" >> "$UPLOAD_DIR/$PUBLISHED_FILE"
            echo "$filename uploaded successfully."
        else
            echo "Error uploading $filename."
        fi
    else
        echo "$filename already uploaded. Skipping."
    fi
    claim_id=$(echo "$output" | grep -oP '(?<="claim_id": ")[^"]*')
    if [ -n "$claim_id" ] && [ "$claim_id" != "$CHANNELID" ]; then 
      echo "Claim ID for $filename: $claim_id"
      echo "$claim_id" >> "$claim_id_log"  # Save claim ID to file
    elif ! grep -Fxq "$claim_id" "claim_id_log"; then
      echo "Claim ID was already found in log."
    else
      echo "Couldn't find claim id."
    fi
done
