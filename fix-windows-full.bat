@echo off
title 🔧 Complete repair of windows system
color 0A

echo [1/12] Disable update service ...
net stop bits
net stop wuauserv
net stop msiserver
net stop cryptsvc
net stop appidsvc

echo [2/12] Renaming the cache folder...
ren %Systemroot%\SoftwareDistribution SoftwareDistribution.old
ren %Systemroot%\System32\catroot2 catroot2.old

echo [3/12] Re-registering important files...
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll

echo [4/12] Reset network and proxy...
netsh winsock reset
netsh winhttp reset proxy

echo [5/12] Cleaning unused drivers...
rundll32.exe pnpclean.dll,RunDLL_PnpClean /DRIVERS /MAXCLEAN

echo [6/12] Scan DISM (scanhealth)...
dism /Online /Cleanup-image /Scanhealth

echo [7/12] Check DISM (checkhealth)...
dism /Online /Cleanup-image /Checkhealth

echo [8/12] Repair Windows image...
dism /Online /Cleanup-image /Restorehealth

echo [9/12] Cleaning Windows components...
dism /Online /Cleanup-image /StartComponentCleanup

echo [10/12] Run SFC to repair system files...
sfc /scannow

echo [11/12] Re-disable the service...
net stop bits
net stop wuauserv
net stop msiserver
net stop cryptsvc
net stop appidsvc

echo [12/12] Done. Please restart your computer.
pause
