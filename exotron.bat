@ECHO OFF

ECHO --------------------------------------------------
ECHO EXOTRON Sandbox Feature Upgrader
timeout /t 2

:: AUDIT POLICY ADJUSTMENTS
ECHO --------------------------------------------------
ECHO Modifying the local Audit Policy
timeout /t 2

auditpol /set /subcategory:"Security State Change" /success:enable /failure:enable
auditpol /set /subcategory:"Security System Extension" /success:enable /failure:enable
auditpol /set /subcategory:"System Integrity" /success:enable /failure:enable
auditpol /set /subcategory:"IPsec Driver" /success:disable /failure:disable
auditpol /set /subcategory:"Other System Events" /success:disable /failure:enable
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Logoff" /success:enable /failure:enable
auditpol /set /subcategory:"Account Lockout" /success:enable /failure:enable
auditpol /set /subcategory:"IPsec Main Mode" /success:disable /failure:disable
auditpol /set /subcategory:"IPsec Quick Mode" /success:disable /failure:disable
auditpol /set /subcategory:"IPsec Extended Mode" /success:disable /failure:disable
auditpol /set /subcategory:"Special Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable /failure:enable
auditpol /set /subcategory:"Network Policy Server" /success:enable /failure:enable
auditpol /set /subcategory:"File System" /success:enable /failure:enable
auditpol /set /subcategory:"Registry" /success:enable /failure:enable
auditpol /set /subcategory:"Kernel Object" /success:enable /failure:enable
auditpol /set /subcategory:"SAM" /success:disable /failure:disable
auditpol /set /subcategory:"Certification Services" /success:enable /failure:enable
auditpol /set /subcategory:"Application Generated" /success:enable /failure:enable
auditpol /set /subcategory:"Handle Manipulation" /success:disable /failure:disable
auditpol /set /subcategory:"File Share" /success:enable /failure:enable
auditpol /set /subcategory:"Filtering Platform Packet Drop" /success:disable /failure:disable
auditpol /set /subcategory:"Filtering Platform Connection" /success:disable /failure:disable
auditpol /set /subcategory:"Other Object Access Events" /success:disable /failure:disable
auditpol /set /subcategory:"Sensitive Privilege Use" /success:disable /failure:disable
auditpol /set /subcategory:"Non Sensitive Privilege Use" /success:disable /failure:disable
auditpol /set /subcategory:"Other Privilege Use Events" /success:disable /failure:disable
auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable
auditpol /set /subcategory:"Process Termination" /success:enable /failure:enable
auditpol /set /subcategory:"DPAPI Activity" /success:disable /failure:disable
auditpol /set /subcategory:"RPC Events" /success:enable /failure:enable
auditpol /set /subcategory:"Audit Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Authentication Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Authorization Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"MPSSVC Rule-Level Policy Change" /success:disable /failure:disable
auditpol /set /subcategory:"Filtering Platform Policy Change" /success:disable /failure:disable
auditpol /set /subcategory:"Other Policy Change Events" /success:disable /failure:enable
auditpol /set /subcategory:"User Account Management" /success:enable /failure:enable
auditpol /set /subcategory:"Computer Account Management" /success:enable /failure:enable
auditpol /set /subcategory:"Security Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Distribution Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Application Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Other Account Management Events" /success:enable /failure:enable
auditpol /set /subcategory:"Directory Service Access" /success:enable /failure:enable
auditpol /set /subcategory:"Directory Service Changes" /success:enable /failure:enable
auditpol /set /subcategory:"Directory Service Replication" /success:disable /failure:disable
auditpol /set /subcategory:"Detailed Directory Service Replication" /success:disable /failure:disable
auditpol /set /subcategory:"Credential Validation" /success:enable /failure:enable
auditpol /set /subcategory:"Kerberos Service Ticket Operations" /success:enable /failure:enable
auditpol /set /subcategory:"Other Account Logon Events" /success:enable /failure:enable
auditpol /set /subcategory:"Kerberos Authentication Service" /success:enable /failure:enable

:: SYSMON
ECHO --------------------------------------------------
ECHO Installing Sysmon
timeout /t 2

Sysmon\Sysmon.exe -u
Sysmon\Sysmon.exe -accepteula -i Sysmon\sysmonconfig-export.xml

:: CLEAR EVENTLOGS
ECHO --------------------------------------------------
ECHO Clearing Eventlogs
timeout /t 2

powershell -NoProfile -ExecutionPolicy Bypass -File tools\Clear-Eventlog.ps1 -LogName Security
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Clear-Eventlog.ps1 -LogName System
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Clear-Eventlog.ps1 -LogName Application
REM powershell -NoProfile -ExecutionPolicy Bypass -File tools\Clear-Eventlog.ps1 -LogName "Microsoft-Windows-Sysmon/Operational"


:: SAMPLE EXECUTION
ECHO --------------------------------------------------
ECHO Executing samples in sub directory ./samples
timeout /t 2
for %%i in (samples\*) do %%i

:: EVENTLOG EXPORT
ECHO --------------------------------------------------
ECHO Exporting Eventlogs
timeout /t 2

powershell -NoProfile -ExecutionPolicy Bypass -File tools\Export-Eventlog.ps1 -LogName Security -Destination C:\eventlog-security.csv
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Export-Eventlog.ps1 -LogName System -Destination C:\eventlog-system.csv
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Export-Eventlog.ps1 -LogName Application -Destination C:\eventlog-application.csv
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Export-Eventlog.ps1 -LogName "Microsoft-Windows-Sysmon/Operational" -Destination C:\eventlog-sysmon.csv

:: Done