# WIP sync to odysee
A guide on how to sync youtube channels and directories/batch upload of video to odysee using lbrynet. 
After searching for guides I gave up looking and went to go figure out myself, but now here's a guide I couldn't find before. 

Requirements: 

yt-dlp (if wanting to sync youtube channels)

a linux distro of your choice (shouldn't matter what you use, but I use arch for this btw)

(No Windows support use Windows Subsystem for Linux or a virtual machine for now at least) 

bash (idk if fish or zsh would work with the scripts i'll be providing)

lbry-desktop

chronyd (for automation of yt-dlp)


Step 1:
Figure out where your lbry is installed at as we will need to point to it in our shell script typically it is in /usr/bin/lbrynet but every system is different

Step 2: 
