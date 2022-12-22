**Auto Fix Script for Debian/Ubuntu**

This repository contains a script that can be used to automatically fix common issues on Debian/Ubuntu based systems.
Requirements
```    
    ## Requirements

    To run this script, you will need the following:

    - Git: The script uses the `git` command to clone the repository. 
    Please ensure that git is installed on your system. 
    You can check if git is installed by running `git --version` in a terminal.
    - Permissions: The script requires password-based sudo privileges to move the main auto fix script to the `bin`     directory. 
    Please ensure that you have the necessary permissions to run the script.


    A Debian/Ubuntu based system
    bash shell (should be installed by default on most systems)
    
```
Installation

To install the script, clone this repository to your local machine using the following command:

```git clone https://github.com/thatguywiththefunnyname/techSupport.git```


This will create a new directory called your-repo on your local machine, and will download all of the files in the repository to that directory.

To update the script to the latest version from this repository, use the run_update.sh script:

```bash run_update.sh```

This script will pull the latest version of the script from this repository, update the permissions of the main auto fix script (update_bot.sh), and place it in the bin directory. The run_update.sh script will then delete the your-repo directory to clean up.
Usage

To use the script, open a terminal and navigate to the bin directory. Then enter the following command:

```bash update_bot.sh```

The script will automatically fix any held back packages on the system.
Limitations

The script is currently only able to fix held back packages on a system. It may not be able to fix all issues on your system. Use the script at your own risk, and make sure to create backups of important data before running the script.
Contributions

If you have any suggestions for improvements to the script, or if you have found any bugs, please open an issue or a pull request. We welcome all contributions to make the script better.
License

The script is licensed under the MIT license. Feel free to use and modify the script as you see fit.
