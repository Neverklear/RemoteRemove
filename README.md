# Remote Access Software Removal Script

This batch script is designed to help remove remote access software commonly used by scammers, such as AnyDesk, TeamViewer, ScreenConnect, and others. The script checks for running processes, removes executable files, and cleans up startup and registry entries associated with the software.

## Features

- **System Restore Point**: Automatically creates a system restore point before making any changes.
- **Registry Backup**: Backs up the registry to the desktop before removing any keys.
- **Process Termination**: Identifies and terminates remote access software processes that are running.
- **File Removal**: Deletes files from common install locations (Program Files, AppData, ProgramData).
- **Startup Cleanup**: Removes the remote software from the user-specific and system-wide startup folders.
- **Registry Cleanup**: Dynamically checks for and deletes registry entries related to the remote access tools.

## Supported Remote Access Software

This script supports the following remote access tools:
- AnyDesk
- TeamViewer
- UltraViewer
- ScreenConnect (ConnectWise Control)
- Splashtop
- LogMeIn
- GoToAssist (formerly GoToMyPC)
- RemotePC
- DameWare
- VNC (RealVNC, TightVNC, UltraVNC)
- Ammyy Admin
- AeroAdmin
- Remote Utilities

## Usage

1. **Download and extract the batch file**.
2. **Run the script as Administrator**:
    - Right-click the batch file and select "Run as administrator".
3. The script will:
    - Create a system restore point.
    - Backup the registry to your desktop.
    - Scan for running remote access software, terminate them if found, and delete the executables.
    - Remove startup entries from both user-specific and system-wide folders.
    - Clean up registry entries associated with these remote access tools.

## Requirements

- **Windows OS**: The script is designed for use on Windows operating systems.
- **Administrator Privileges**: The script must be run with administrator privileges to perform file deletions, registry modifications, and process terminations.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.

---

**Disclaimer**: This script is designed for IT professionals to help remove potentially unwanted remote access tools. Use it responsibly.
