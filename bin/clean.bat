@echo off
echo.
echo [信息] 清理整个项目target缓存路径。
echo.

%~d0
cd %~dp0

cd ..
call mvn clean

pause