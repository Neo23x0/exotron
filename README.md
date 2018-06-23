# exotron
Sandbox Feature Upgrader

# What it does

It's so sad that big sandbox vendors do not provide the information that a blue teamer would like to see in the reports. For me it was always important to see Windows Eventlog events in these reports. The sandboxes that I use do not provide this feature. So I decided to add that feature to the samples that I drop in form of a wrapper. 

Exotron wraps the sample in a set of commands that run before and after the sample exeuction. 

This is what happens in the current PoC like version:

1. Activates all event types in the local audit policy of the Windows system
2. Clears the current eventlog entries in Security, Applicaion, System
3. Installs Sysmon (yeah!)
4. Runs samples in a `.\samples` sub directory (of the SFX)
5. Exports the Eventlog and Sysmon entries as CSV to files on disk (which can then be downloaded as "dropped files")

# Downsides / Todo's

- The report will be a mess as it contains all processes that the exotron wrapper has caused in the session
- Filter some of the actions caused by ExoTron from the eventlogs during the export

# Getting started

1. Download Sysmon from the Microsoft [website](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon) and place it in the folder `.\Sysmon`
2. Get the newest version of [SwiftOnSecurity's sysmon configuration](https://github.com/SwiftOnSecurity/sysmon-config) or create your own and place it in the `.\Sysmon` directory
3. Get Python3 if it is not already there
4. Place samples in the `.\samples` sub folder
5. Run `python3 exotron.py --debug`
6. Drop the `exotron-package.exe` into a sandbox of your choice

# Requirements

- Sandbox should have UAC disabled

# Status

Experimental PoC - I made it for myself and thought that others may find it useful too. If people like the idea, maybe I'll put more effort in it. 

# Screenshots

![SFX Creation](https://github.com/Neo23x0/exotron/blob/master/screenshots/screen2.png "SFX creation")
![What it does](https://github.com/Neo23x0/exotron/blob/master/screenshots/screen5.png "Code")
![Sandbox Run](https://github.com/Neo23x0/exotron/blob/master/screenshots/screen6.png "Sandbox Run")
![Sandbox Dropped File](https://github.com/Neo23x0/exotron/blob/master/screenshots/screen7.png "Sandbox Dropped File")



