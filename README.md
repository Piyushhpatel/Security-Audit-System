# Security Audit System
## Overview
This is a Plug-and-Play Security Audit System! (in simpler term sort of portable antivirus for now ). This project is designed to provide a seamless and efficient solution for conducting security audits on computer systems. The way this work is that we plug the key into the system where we intitate the security scan the program then show the status to a live dashboard. This system is sort of intended to work on any type of computer not just our traditional computer but there are some part that we need to focus on to acheive the intended results.

## Features
- *Plug-and-Play Functionality:* Simply connect the security audit system to a computer's USB port, run the program and the scanning process will begin instantly.
- *Real-time Dashboard:*  The results of the security audit are displayed in real-time on a user-friendly dashboard. This allows users to quickly assess the security status and take immediate action if needed.
- *Intuitive User Interface:*  The dashboard features an intuitive and visually appealing interface, making it easy for both technical and non-technical users to understand the security assessment results.

## Getting Started 
So if you wanna check it or use it how can you do that let's go through that

### Prerequisite
- Computer with python and flutter set up in it to build it
- Internet connection for realtime update

### Building
#### Key Part
1. Clone the repository
2. Create the virtual enviornment you can skip this but good practice
3. Now go to firebase and create a project and download the key.json and create a realtime database
4. Open the connection.py and fill the neccessary firebase infomation and build the program store that in a key

#### Dashboard
1. For the dashboard you can just go in the dashboard folder and run the command
   ```
   Flutter build apk
   ```

## Future Scope and Improvement 
This project is not quite there yet I wanted to make the key part so that it automatically invokes but it windows security system doens't really allow that. Also right now the scan it based on basic heurisitic based approach but in future am gonna implement machine learning and deep learning to imporve the audit system and give more extensive and comprehensive result any suggest would be great
