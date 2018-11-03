@ECHO OFF
set PATH=D:\Server\
ECHO Path : %PATH%
ECHO Starting NGINX ...
%PATH%RunHiddenConsole.exe %PATH%nginx.exe
EXIT
