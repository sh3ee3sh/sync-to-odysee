# WIP sync to odysee
**this repository is going private for the people cloning this **

A guide on how to sync youtube channels and directories/batch upload of video to odysee using lbrynet. 
After searching for well-documented guides for beginners I gave up looking and went to go figure out myself, but now here's a guide I couldn't find before.

## Disclaimers 

**Due to the uncertainty of the platform's future I recommend archiving everything locally till it becomes more clear.**  **

**I am not affiliated with the team behind odysee or lbry.** 

**Copyrighted material has the possiblity of getting striked and blocking you out of your channel I do not take responsibility if you get striked.** 

** this guide will have yt-dlp setup to the point where it will make it easy to sync to other platforms, but you will need to figure out how to upload to your platform of choice after. 

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

Step 1: Download requirements 

Step 2: If you haven't already create an account on odysee

Step 3: launch lbry and login with the details you used on odysee (i dont know if this acutally required but i did it)

Step 4: we now want to find our claim id it is located on your about page on odysee


Step 5: We are now going to setup our script in bash

clone this repo or download it as a zip
```
git clone https://github.com/dgmsheesh/sync-to-odysee
```


we are going to use default_incremental_lbry.sh 

open it with your text editor of choice

now we plug everything that we have in 



## To-do
- [ ] add dynamic playlisting based on user input to script using collection function 
- [ ] not related to this repository but create ability to autoupload using autovod
