# WIP sync to odysee
**this repository is going private for the people cloning this **

A guide on how to sync youtube channels and directories/batch upload of video to odysee using lbrynet. 
After searching for guides I gave up looking and went to go figure out myself, but now here's a guide I couldn't find before.

## Disclaimers 

**Due to the uncertainty of the platform's future I recommend archiving everything locally till it becomes more clear.**  **

**I am not affiliated with the team behind odysee or lbry.** 

**Copyrighted material has the possiblity of getting striked and blocking you out of your channel I do not take responsibility if you get striked.** ***

** this guide will have yt-dlp setup to the point where it will make it easy to sync to other platforms, but you will need to figure out how to upload to your platform of choice after. 

*** lbry will not to my knowledge 

## Requirements
```
yt-dlp (if wanting to sync anything basically on the internet)

a linux distro of your choice (shouldn't matter what you use, but I use arch for this btw)

(No Windows support use Windows Subsystem for Linux or a virtual machine for now at least) 

bash (idk if fish or zsh would work with the scripts i'll be providing)

lbry-desktop
```
**OPTIONAL**

ffmpeg (lbry and odysee do support 4k BUT it is incredibly slow I recommend scaling down your videos if you actually want it to be watchable on odysee) 

cronie (for automation of yt-dlp)

[autovod](https://github.com/jenslys/autovod/) (automatic recording of twitch/youtube/kick vods) **

** I have issues using autovod something related to streamlink and useragents on kick, it is a good program, but it may need some troubleshooting on your end. 

## Steps

Step 1: Download requirements 

Step 2: If you haven't already create an account on odysee

Step 3: launch lbry and login with the details you used on odysee

Step 4: we now want to find our claim
## To-do
(-) Migrate scripts to python as LBRY doesn't have certain functionalities 
