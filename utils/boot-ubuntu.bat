@echo off

chcp 65001
cd /d "%~dp0/.."

wsl -d Ubuntu-22.04 sh -c "sed -i 's/\r//' ./main.sh && ./main.sh ubuntu"

if %ERRORLEVEL% == 0 (
    timeout /nobreak 5
) else (
    pause
)
