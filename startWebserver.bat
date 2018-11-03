@ECHO OFF
ECHO Current location is %~dp0
ECHO WebServer : NGINX 1.4, PHP 7.2
ECHO DBMS : MariaDB
ECHO.
:START
ECHO Select your case
ECHO   1 - START Webserver AND DBMS
ECHO   2 - START DBMS
ECHO   3 - START WebServer
ECHO   4 - STOP Webserver AND DBMS
ECHO   5 - STOP DBMS
ECHO   6 - STOP WebServer
ECHO   7 - Change DBMS root password
ECHO   Other case - Exit
ECHO.
set /P N=Input case number: 
cls
ECHO ------------------ STATUS ------------------
goto :Case-%N%

:Case-1
	ECHO Case : %N%  START Webserver AND DBMS
	ECHO Starting DBMS...
	%~dp0RunHiddenConsole.exe %~dp0DBMS\bin\mysqld.exe --no-defaults
	ECHO Starting PHP FastCGI...
	%~dp0RunHiddenConsole.exe %~dp0php\php-cgi.exe -b 127.0.0.1:9000 -c %~dp0php.ini
	ECHO Starting NGINX ...
	%~dp0RunHiddenConsole.exe %~dp0nginx.exe 
	goto :RETURN
:Case-2
	ECHO Case : %N% START DBMS
	ECHO Starting DBMS... 
	%~dp0RunHiddenConsole.exe %~dp0DBMS\bin\mysqld.exe --no-defaults 
	goto :RETURN
:Case-3
	ECHO Case : %N% START WebServer
	ECHO Starting PHP FastCGI... 
	%~dp0RunHiddenConsole.exe %~dp0php\php-cgi.exe -b 127.0.0.1:9000 -c %~dp0php.ini
	ECHO Starting NGINX ...
	%~dp0RunHiddenConsole.exe %~dp0nginx.exe
	goto :RETURN
:Case-4
	ECHO Case : %N%  STOP Webserver AND DBMS
	taskkill /f /IM nginx.exe
	taskkill /f /IM php-cgi.exe
	%~dp0DBMS\bin\mysqladmin.exe -u root -p shutdown
	goto :RETURN
:Case-5
	ECHO Case : %N% STOP DBMS
	%~dp0DBMS\bin\mysqladmin.exe -u root -p shutdown
	goto :RETURN
:Case-6
	ECHO Case : %N% STOP WebServer
	taskkill /f /IM nginx.exe
	taskkill /f /IM php-cgi.exe
	goto :RETURN
:Case-7
	ECHO Case : %N% Change DBMS root password
	ECHO.
	set /p oldPSS=Enter old password : 
	set /p newPSS=Enter new password : 
	ECHO.
	
	set /P c=Are you sure you want to change default root password[Y/N]?
	if /I "%c%" EQU "Y" goto :ConfirmChange
	if /I "%c%" EQU "N" goto :CancelInput
	goto :ERRORInput
	
	:ConfirmChange
	goto :RETURN
	:CancelInput
	ECHO Cancel change password.
	goto :RETURN
	
:ERRORInput
	ECHO Invalid input.
:RETURN
echo --------------------------------------------
ECHO.
goto :START
pause

