@echo off

echo Generating repository file list...

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Get-ChildItem 'C:\Gametools\PoE2BuildOptimizer' -Recurse -File ^| Sort-Object FullName ^| Select-Object FullName ^| Out-File 'C:\Gametools\PoE2BuildOptimizer\repository_file_list.txt'"

echo.
echo File list created:
echo C:\Gametools\PoE2BuildOptimizer\repository_file_list.txt
echo.

pause