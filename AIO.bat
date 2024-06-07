@echo off
title Windows Diagnostic AIO Multitool
color 0F

:main
cls
echo ===============================
echo    Welcome to Windows Diagnostic       
echo              AIO Multitool
echo ===============================
echo.
echo [1] Basic System Information
echo [2] Network Information
echo [3] Run System File Checker (SFC)
echo [4] Service Management
echo [5] Drive Health Check
echo [6] Backup and Restore
echo [7] Internet Speed Test
echo [8] Exit
echo.
set /p choice=Enter your choice (1-8): 

if %choice%==1 goto basic_info
if %choice%==2 goto network_info
if %choice%==3 goto run_sfc
if %choice%==4 goto service_mgmt
if %choice%==5 goto drive_health
if %choice%==6 goto backup_restore
if %choice%==7 goto internet_speed_test
if %choice%==8 goto exit
echo Invalid choice. Please select a valid option.
pause
goto main

:basic_info
cls
echo ===============================
echo        Basic System Information        
echo ===============================
echo Gathering information, please wait...
echo.

for /f "tokens=*" %%i in ('powershell -command "Get-WmiObject Win32_Processor | Select-Object -ExpandProperty Name"') do set "CPUName=%%i"

for /f "tokens=*" %%i in ('powershell -command "Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory"') do set "TotalMemory=%%i"

set /a TotalMemoryGB=%TotalMemory:~0,-6% / 1024

echo [+] Operating System: %OS%
echo [+] Computer Name: %COMPUTERNAME%
echo [+] User Name: %USERNAME%
echo [+] System Directory: %SystemRoot%
echo [+] Processor: %CPUName%
echo [+] Total Physical Memory: %TotalMemoryGB% GB
echo.
echo Press any key to return to the main menu.
pause >nul
goto main

:network_info
cls
echo ===============================
echo         Network Information        
echo ===============================
echo.
echo [1] View IP Configuration Details
echo [2] View Network Adapters and Their Statuses
echo [3] Ping a Host
echo [4] Traceroute to a Host
echo [5] View Wi-Fi Network Information
echo [6] Network Troubleshooting
echo [7] Back to Main Menu
echo.
set /p net_choice=Enter your choice (1-7): 

if %net_choice%==1 goto ip_config
if %net_choice%==2 goto net_adapters
if %net_choice%==3 goto ping_host
if %net_choice%==4 goto tracert_host
if %net_choice%==5 goto wifi_info
if %net_choice%==6 goto net_troubleshooting
if %net_choice%==7 goto main
echo Invalid choice. Please select a valid option.
pause
goto network_info

:ip_config
cls
echo ===============================
echo      IP Configuration Details          
echo ===============================
echo.
ipconfig /all
echo.
echo Press any key to return to the network menu.
pause >nul
goto network_info

:net_adapters
cls
echo ===============================
echo   Network Adapters and Their Statuses     
echo ===============================
echo.
powershell -command "Get-NetAdapter"
echo.
echo Press any key to return to the network menu.
pause >nul
goto network_info

:ping_host
cls
echo ===============================
echo           Ping a Host     
echo ===============================
echo.
set /p host=Enter the host to ping: 
echo.
ping %host%
echo.
echo Press any key to return to the network menu.
pause >nul
goto network_info

:tracert_host
cls
echo ===============================
echo      Traceroute to a Host     
echo ===============================
echo.
set /p tracehost=Enter the host to traceroute: 
echo.
tracert %tracehost%
echo.
echo Press any key to return to the network menu.
pause >nul
goto network_info

:wifi_info
cls
echo ===============================
echo      Wi-Fi Network Information     
echo ===============================
echo.
:: Get Wi-Fi information using PowerShell
powershell -command "netsh wlan show interfaces"
echo.
echo Press any key to return to the network menu.
pause >nul
goto network_info

:net_troubleshooting
cls
echo ===============================
echo       Network Troubleshooting        
echo ===============================
echo.
echo [1] Automated Network Checks
echo [2] DNS Flush and Renewal
echo [3] Back to Network Menu
echo.
set /p net_trouble_choice=Enter your choice (1-3): 

if %net_trouble_choice%==1 goto auto_net_checks
if %net_trouble_choice%==2 goto dns_flush
if %net_trouble_choice%==3 goto network_info
echo Invalid choice. Please select a valid option.
pause
goto net_troubleshooting

:auto_net_checks
cls
echo ===============================
echo       Automated Network Checks       
echo ===============================
echo.
echo Performing automated network checks...
echo.
ipconfig /release
ipconfig /renew
echo.
ping 8.8.8.8
echo.
echo Network checks completed.
echo.
echo Press any key to return to the network troubleshooting menu.
pause >nul
goto net_troubleshooting

:dns_flush
cls
echo ===============================
echo        DNS Flush and Renewal          
echo ===============================
echo.
:: Flush and renew DNS
ipconfig /flushdns
ipconfig /registerdns
echo.
echo DNS flush and renewal completed.
echo.
echo Press any key to return to the network troubleshooting menu.
pause >nul
goto net_troubleshooting

:run_sfc
cls
echo ===============================
echo       System File Checker (SFC)          
echo ===============================
echo.
echo Running System File Checker. This may take a while...
sfc /scannow
echo.
echo System File Checker completed.
echo.
echo Press any key to return to the main menu.
pause >nul
goto main

:service_mgmt
cls
echo ===============================
echo          Service Management       
echo ===============================
echo.
echo [1] List Running Services
echo [2] List Stopped Services
echo [3] Start a Service
echo [4] Stop a Service
echo [5] Restart a Service
echo [6] Back to Main Menu
echo.
set /p svc_choice=Enter your choice (1-6): 

if %svc_choice%==1
goto list_running_services
if %svc_choice%==2 goto list_stopped_services
if %svc_choice%==3 goto start_service
if %svc_choice%==4 goto stop_service
if %svc_choice%==5 goto restart_service
if %svc_choice%==6 goto main

:list_running_services
cls
echo ===============================
echo          List Running Services       
echo ===============================
echo.
powershell -command "Get-Service | Where-Object {$_.Status -eq 'Running'}"
echo.
echo Press any key to return to the service management menu.
pause >nul
goto service_mgmt

:list_stopped_services
cls
echo ===============================
echo          List Stopped Services       
echo ===============================
echo.
powershell -command "Get-Service | Where-Object {$_.Status -eq 'Stopped'}"
echo.
echo Press any key to return to the service management menu.
pause >nul
goto service_mgmt

:start_service
cls
echo ===============================
echo             Start a Service       
echo ===============================
echo.
set /p svc_name=Enter the name of the service to start: 
echo.
:: Start a service using PowerShell
powershell -command "Start-Service %svc_name%"
echo.
echo Service "%svc_name%" started successfully.
echo.
echo Press any key to return to the service management menu.
pause >nul
goto service_mgmt

:stop_service
cls
echo ===============================
echo              Stop a Service       
echo ===============================
echo.
set /p svc_name=Enter the name of the service to stop: 
echo.
powershell -command "Stop-Service %svc_name%"
echo.
echo Service "%svc_name%" stopped successfully.
echo.
echo Press any key to return to the service management menu.
pause >nul
goto service_mgmt

:restart_service
cls
echo ===============================
echo           Restart a Service       
echo ===============================
echo.
set /p svc_name=Enter the name of the service to restart: 
echo.
powershell -command "Restart-Service %svc_name%"
echo.
echo Service "%svc_name%" restarted successfully.
echo.
echo Press any key to return to the service management menu.
pause >nul
goto service_mgmt

:drive_health
cls
echo ===============================
echo          Drive Health Check       
echo ===============================
echo.
powershell -command "Get-WmiObject Win32_DiskDrive | Select-Object Model, @{Name='HealthStatus'; Expression={If ($_.Status -eq 'OK') {'Healthy'} Else {'Unhealthy'}}}"
echo.
echo Press any key to return to the main menu.
pause >nul
goto main

:backup_restore
cls
echo ===============================
echo          Backup and Restore       
echo ===============================
echo.
echo [1] System Restore Points
echo [2] Back to Main Menu
echo.
set /p backup_choice=Enter your choice (1-2): 

if %backup_choice%==1 goto restore_points
if %backup_choice%==2 goto main

:restore_points
cls
echo ===============================
echo        System Restore Points       
echo ===============================
echo.
powershell -command "Get-ComputerRestorePoint | Select-Object Description, SequenceNumber, ConvertTo-Csv"
echo.
echo Press any key to return to the backup and restore menu.
pause >nul
goto backup_restore

:internet_speed_test
cls
echo ===============================
echo        Internet Speed Test       
echo ===============================
echo.
echo Running internet speed test. Please wait...
echo.

powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py', 'speedtest.py')"

:: Run Speedtest
python speedtest.py

echo.
echo Internet speed test completed.
echo.
echo Press any key to return to the main menu.
pause >nul
goto main

:exit
exit
