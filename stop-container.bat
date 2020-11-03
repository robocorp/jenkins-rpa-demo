@echo off
pushd .

echo.
echo Stopping and removing container.. Continue?
set /P continue="(yes / no): "
IF "%continue%"=="yes" goto START
goto :CANCEL

:START
echo.
docker stop robodemo  || goto :ERROR
docker rm robodemo || goto :ERROR
echo.
echo Container stopped

:CANCEL
popd
goto :EOF

:ERROR
echo.
popd
pause
exit /b %errorlevel%
