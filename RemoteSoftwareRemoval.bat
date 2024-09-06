
@echo off
:: Check if the script is run as administrator
NET SESSION >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Please run this script as administrator.
    pause
    exit /b
)

:: Create a system restore point
echo Creating a system restore point...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Pre-RemoteSoftwareRemoval", 100, 7
echo System restore point created.

:: Backup the registry to Desktop
echo Backing up the registry...
set backupFile=%userprofile%\Desktop\RegistryBackup.reg
reg export "HKEY_CURRENT_USER" "%backupFile%" /y
echo Registry backup saved to %backupFile%.

:: List of remote access software executables to search for
set "processes=AnyDesk.exe TeamViewer.exe TeamViewer_Desktop.exe UltraViewer.exe ScreenConnect.Client.exe ScreenConnect.ClientService.exe SplashtopRemoteService.exe SRManager.exe LogMeIn.exe LMIGuardian.exe g2ax_service.exe g2mcomm.exe RemotePCService.exe rpclient.exe DWRCS.exe DameWare.exe winvnc.exe vncserver.exe vncviewer.exe AA_v3.exe aeroadmin.exe rutserv.exe rview.exe"

:: Function to search and remove registry entries
echo Searching and removing registry entries...
for %%p in (AnyDesk TeamViewer UltraViewer ScreenConnect Splashtop LogMeIn GoToAssist RemotePC DameWare VNC Ammyy AeroAdmin RemoteUtilities) do (
    echo Searching for %%p entries in the registry...
    for /F "tokens=*" %%R in ('reg query HKCU /F %%p /S /K') do (
        echo Deleting %%R...
        reg delete "%%R" /f
    )
    for /F "tokens=*" %%R in ('reg query HKLM /F %%p /S /K') do (
        echo Deleting %%R...
        reg delete "%%R" /f
    )
    for /F "tokens=*" %%R in ('reg query HKU /F %%p /S /K') do (
        echo Deleting %%R...
        reg delete "%%R" /f
    )
)

echo Scanning for remote access software...

:: Loop through each process and check if it's running
for %%p in (%processes%) do (
    tasklist /FI "IMAGENAME eq %%p" | find /I "%%p" >nul
    if not errorlevel 1 (
        echo %%p is running, terminating process...
        taskkill /F /IM %%p
        echo Deleting %%p executable...
        :: Delete from Program Files and AppData paths
        del /F /Q "C:\Program Files\%%p" 2>nul
        del /F /Q "C:\Program Files (x86)\%%p" 2>nul
        del /F /Q "C:\Users\%USERNAME%\AppData\Local\ScreenConnect Client\%%p" 2>nul
        del /F /Q "C:\Users\%USERNAME%\AppData\Local\Apps\%%p" 2>nul
        del /F /Q "C:\ProgramData\ScreenConnect Client\%%p" 2>nul
        del /F /Q "C:\ProgramData\Splashtop\%%p" 2>nul
    ) else (
        echo %%p is not running.
    )
)

echo Removing from Startup Folder...
:: Remove from user-specific startup folder
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\AnyDesk.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\TeamViewer.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\UltraViewer.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\ScreenConnect.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Splashtop.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\LogMeIn.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\GoToAssist.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\RemotePC.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\DameWare.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\VNC.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\AmmyyAdmin.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\AeroAdmin.lnk" 2>nul
del /F /Q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\RemoteUtilities.lnk" 2>nul

:: Remove from system-wide startup folder
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\AnyDesk.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\TeamViewer.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\UltraViewer.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\ScreenConnect.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\Splashtop.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\LogMeIn.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\GoToAssist.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\RemotePC.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\DameWare.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\VNC.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\AmmyyAdmin.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\AeroAdmin.lnk" 2>nul
del /F /Q "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\RemoteUtilities.lnk" 2>nul

echo Removing from Windows Registry...
:: Remove startup entries from the registry
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v AnyDesk /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v TeamViewer /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v UltraViewer /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v ScreenConnect /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v Splashtop /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v LogMeIn /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v GoToAssist /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v RemotePC /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v DameWare /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v VNC /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v AmmyyAdmin /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v AeroAdmin /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v RemoteUtilities /f

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v AnyDesk /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v TeamViewer /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v UltraViewer /f
