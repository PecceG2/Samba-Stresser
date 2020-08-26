[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<br />
<p align="center">
  <a href="https://github.com/PecceG2/Samba-Stresser">
    <img src="https://pecceg2.github.io/Samba-Stresser/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Samba Stresser</h3>

  <p align="center">
    Samba Stresser is a PowerShell script that allows you to perform filesystem read/write stress tests, asyncronic with multiples jobs in simultaneous.
    <br />
    <a href="https://github.com/PecceG2/"><strong>View all my projects »</strong></a>
    <br />
    <br />
    <a href="https://github.com/PecceG2/Samba-Stresser/issues">Report Bug</a>
    ·
    <a href="https://github.com/PecceG2/Samba-Stresser/blob/master/LICENSE.md">View License</a>
    ·
    <a href="https://github.com/PecceG2/Samba-Stresser/issues">Request Feature</a>
  </p>
</p>

## Screenshots ##
![Screenshot](https://pecceg2.github.io/Samba-Stresser/graph_network01.png)
![Screenshot](https://pecceg2.github.io/Samba-Stresser/random_files.png)

## Building

The [Samba-Stresser](https://github.com/PecceG2/Samba-Stresser) repository provides a PowerShell script `SMB_Stresser.ps1`, edit this file with any text editor (Notepad++, Notepad or similar) and customize:


```SMB_Stresser

############# STRESS CONFIGURATION #############

$ParallelJobs = 30                # Parallel jobs count
$JobSleepTime = 0                 # Time in seconds between jobs (0 for no delay)

########### END STRESS CONFIGURATION ###########
	
############### JOB CONFIGURATION ###############

$TempFolder = "C:\Users\Administrador\Desktop\tmp"               # Stress TMP copy folder (It auto-delete on finish job)
$DestPath = "S:"                                                 # Stress destination folder (Mount your SMB or NFS and attach here)
$RandomFilesPerJob = 10                                          # Random files to create per job

############# END JOB CONFIGURATION #############
	
```

Then save the script file.


## Running
Execute PowerShell script from bash (Open `cmd.exe` on script location -> Run script with `PowerShell.exe SMB_Stresser.ps1` command.


## License
>You can check out the full license [here](https://github.com/PecceG2/Samba-Stresser/blob/master/LICENSE.md)

This project is licensed under the terms of the **MIT** license.

[contributors-shield]: https://img.shields.io/github/contributors/PecceG2/Samba-Stresser.svg?style=flat-square
[contributors-url]: https://github.com/PecceG2/Samba-Stresser/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/PecceG2/Samba-Stresser.svg?style=flat-square
[forks-url]: https://github.com/PecceG2/Samba-Stresser/network/members
[stars-shield]: https://img.shields.io/github/stars/PecceG2/Samba-Stresser.svg?style=flat-square
[stars-url]: https://github.com/PecceG2/Samba-Stresser/stargazers
[issues-shield]: https://img.shields.io/github/issues/PecceG2/Samba-Stresser.svg?style=flat-square
[issues-url]: https://github.com/PecceG2/Samba-Stresser/issues
[license-shield]: https://img.shields.io/github/license/PecceG2/Samba-Stresser.svg?style=flat-square
[license-url]: https://github.com/PecceG2/Samba-Stresser/blob/master/LICENSE.md