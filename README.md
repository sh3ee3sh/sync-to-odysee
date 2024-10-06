# WIP sync to odysee
A guide on how to sync directories/do batch upload of video to odysee using lbrynet. 
After searching for guides I gave up looking and went to go figure out myself, but now here's a guide for anyone else before with my situation. 

Requirements: 

yt-dlp (if wanting to sync youtube channels)

a linux distro of your choice I use Arch but I don't think this will make much of a difference if you use something else

(No Windows support use Windows Subsystem for Linux for now at least) 

bash (idk if fish or zsh would work with the scripts i'll be providing)

lbry-desktop

chronyd (for automation of yt-dlp)


Step 1:
Figure out where your lbry is installed at as we will need to point to it in our shell script typically it is in /usr/bin/lbrynet but every system is different

Step 2: 
