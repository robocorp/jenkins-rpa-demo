@echo off
pushd .

echo.
echo Building docker image...
docker build -t robodemo . || goto :ERROR

echo.
echo Ready to start.. Continue?
set /P continue="(yes / no): "
IF "%continue%"=="yes" goto :START
goto :CANCEL

:START
echo.
echo Starting jenking docker image...
docker run -p 8080:8080 --env JAVA_OPTS=-Dhudson.model.DirectoryBrowserSupport.CSP= -v jenkins_home://var/jenkins_home -v //var/run/docker.sock:/var/run/docker.sock --detach --name robodemo robodemo || goto :ERROR
echo.
echo Docker is now running open your browser: http://localhost:8080
echo Login with admin / RoboCorpRules2020!


:CANCEL
popd
goto :EOF

:ERROR
echo.
echo.
echo Failed with error %errorlevel%!
popd
pause
exit /b %errorlevel%
