curl -L -o parsec.exe https://github.com/DangDev/QEMU/releases/download/Download/parsec-windows.exe
curl -L -o onedrive.exe https://github.com/DangDev/QEMU/releases/download/Download/OneDriveSetup.exe
curl -L -o ultraviewer.exe https://github.com/DangDev/QEMU/releases/download/Download/UltraViewer_setup_6.5_vi.exe
curl -L -o turnoffIE.ps1 https://raw.githubusercontent.com/DangDev/QEMU/main/turnoffIE.ps1
powershell.exe .\turnoffIE.ps1
ultraviewer.exe /VERYSILENT
onedrive.exe /VERYSILENT
