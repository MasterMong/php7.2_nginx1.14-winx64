@ECHO OFF
set PATH=D:\Server\
ECHO Path : %PATH%
ECHO Starting PHP FastCGI...
%PATH%RunHiddenConsole.exe %PATH%php\php-cgi.exe -b 127.0.0.1:9000 -c %PATH%php.ini
ECHO Starting NGINX ...
%PATH%RunHiddenConsole.exe %PATH%nginx.exe
exit
