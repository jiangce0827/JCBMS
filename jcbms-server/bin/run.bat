@echo off
setlocal EnableExtensions

echo.
echo [INFO] Starting JCBMS server from jar.
echo.

set "BASE_DIR=%~dp0.."
set "ENV_FILE=%BASE_DIR%\.env"
set "TARGET_DIR=%BASE_DIR%\jcbms-admin\target"

if exist "%ENV_FILE%" (
    echo [INFO] Loading environment from %ENV_FILE%
    for /f "usebackq eol=# tokens=1,* delims==" %%A in ("%ENV_FILE%") do (
        set "%%A=%%B"
    )
) else (
    echo [WARN] .env file not found: %ENV_FILE%
    echo [WARN] Copy .env.example to .env and adjust values if needed.
)

if not exist "%TARGET_DIR%\jcbms-admin.jar" (
    echo [ERROR] Jar not found: %TARGET_DIR%\jcbms-admin.jar
    echo [ERROR] Run "mvn clean package -Dmaven.test.skip=true" from jcbms-server first.
    pause
    exit /b 1
)

cd /d "%TARGET_DIR%"

set "JAVA_OPTS=-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m"

java %JAVA_OPTS% -jar jcbms-admin.jar
set "EXIT_CODE=%ERRORLEVEL%"

pause
exit /b %EXIT_CODE%
