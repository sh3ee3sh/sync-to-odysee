# Intro

A guide on how to mass/batch upload video and manually archiving video without using Odysee's built in system. 
After searching for well-documented guides for beginners I gave up looking and went to go figure out myself, but now here's a guide I couldn't find before.

## Disclaimers 
**This is experimental. Not everything will work correctly right now, and this is unnecessarily complex I will try to fix it when I have free time.**

**Due to the uncertainty of the platform's future I recommend archiving everything locally till it becomes more clear.**

**I am not affiliated with the team behind odysee or lbry.** 

**Copyrighted material has the possiblity of getting striked and blocking you out of your channel I do not take responsibility if you get striked.** 

**Reminder: Anything NSFW isn't allowed on odysee unless tagged with Mature.**

## Requirements
```
yt-dlp

a linux distro

bash 

lbry-desktop
```
**OPTIONAL**

cronie (for automation of yt-dlp)

[autovod](https://github.com/jenslys/autovod/) (automatic recording of twitch/youtube/kick vods) **

** I have issues using autovod something related to streamlink and useragents on kick, it is a good program, but it may need some troubleshooting on your end. 

## Steps

Step 1 - Download requirements 
-
Step 2 - If you haven't already create an account on odysee and do some quests to get some tokens
-
Step 3 - launch lbry and login with the details you used on odysee (i dont know if this acutally required but i did it)
-
Step 4 - we now want to find our claim id it is located on your about page on odysee
-
![image](https://github.com/user-attachments/assets/d3d2556b-dd22-438d-94ce-8fc9a8e5c81e)


Step 5 - We are now going to setup our script
-
clone this repo or download it as a zip
```
git clone https://github.com/sh3ee3sh/sync-to-odysee
```

make a copy of default_incremental_lbry.sh then open with your text editor of choice

change UPLOAD_DIR to your desired directory

put your channel id in CHANNELID quotes

Step 6 - Acquire the videos
-
I aliased this command to make it easier to ~/.bashrc (don't forget to source ~/.bashrc)
```
alias yt-dlpsync='yt-dlp -f bestvideo[ext=mp4]+bestaudio[ext=aac]/mp4 --merge-output-format mp4 --ppa "ffmpeg: -movflags +faststart" --write-thumbnail --convert-thumbnails png --write-description --write-info-json -o "%(title)s/%(title)s.%(ext)s"'
```
so you can use this one of two ways use a txt file to do more than one channel or just do a channel link or single youtube video 
```
yt-dlpsync https://www.youtube.com/@username/videos
```
you can specify what txt file with -a
```
yt-dlpsync -a links.txt
```
this will download to the directory you are currently in so don't forget to use cd

Step 7 - Setup our files
-
couple more aliases to make this as simple as possible (dont forget to source ~/.bashrc)
```
alias maketagstxt='find . -name "*.info.json" -exec sh -c '\''jq -r ".tags[]? // empty" "$1" > "$(dirname "$1")/tags.txt"'\'' _ {} \;'
alias makedescription='find . -name "*.description" -exec sh -c '"'"'mv "$1" "$(dirname "$1")/video.description"'"'"' _ {} \;'
```
So these are to make this so that our script can read everything in the directory

Go to your directory where all your files are located and run the commands you want

Step 8 - Run our script
-
```
chmod +x renamed_incremental_lbry.sh
bash renamed_incremental_lbry.sh
```
enjoy vids 

**Optional**
-
<details>
<summary><strong>Setting up autodownload and autoupload using cronie to actually make this incremental</strong></summary>

- Step 1: Download cronie using your package manager
``` 
sudo pacman -S cronie
```
- Step 2: Enable and start cronie using systemd
```
sudo systemctl enable cronie
sudo systemctl start cronie --now
```
- Step 3: Add our yt-dlp command without the alias to cronie's tasks

*crontab uses a terrible text editor by default use "export EDITOR=yourtexteditorofchoicehere" in your ~/.bashrc file to change it*
```
crontab -e

0 11 * * * /usr/bin/yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=aac]/mp4' --write-thumbnail --convert-thumbnails png --write-description --write-info-json --merge-output-format mp4 --ppa "ffmpeg: -movflags +faststart" -P "/home/user/Videos/channel" -o "\%(title)s/\%(title)s.\%(ext)s" https://www.youtube.com/@username/videos
```
This command runs daily at 11 am everyday. Edit the second number value to your desired time in the 24 hour format. Add a comma with another number if you want multiple intervals ie: 11,18.

First number value specifies minutes

The -P option specifies directory so change as needed. You can also use the -a option here, but you will need to point to the directory of the txt file ex: "/home/user/Videos/mylinks.txt" and replace the youtube channel link with it instead. 

- Step 4: add our upload script to cronie
```
crontab -e
```

</details>
<details>
<summary><strong>Thumbnailing</strong></summary>

I use jivan's script [here](https://gist.github.com/jivanpal/9b6f5d51ad976daaccc1f0f841807bb0). I found some issues with speech not working for certain thumbnails, so I dont recommend this right now. I'll try and figure out another way later. 

</details>

## To-Do (bold = priority)
- [ ] **add playlisting to script using lbrynet collection**
- [ ] not related to this repository but create ability to autoupload using autovod
- [ ] **fix claim id stuff**
- [ ] find a better way to thumbnail
- [x] ~~make this incremental~~
