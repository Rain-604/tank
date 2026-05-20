@echo off
setlocal

set "APP_DIR=%~dp0"
set "MSYS_UCRT_BIN=C:\msys64\ucrt64\bin"

if not exist "%APP_DIR%TankAssignment.exe" (
  echo TankAssignment.exe not found in %APP_DIR%
  exit /b 1
)

if not exist "%MSYS_UCRT_BIN%" (
  echo MSYS2 UCRT64 bin folder not found: %MSYS_UCRT_BIN%
  exit /b 1
)

copy /Y "%MSYS_UCRT_BIN%\libfreeglut.dll" "%APP_DIR%" >nul
copy /Y "%MSYS_UCRT_BIN%\glew32.dll" "%APP_DIR%" >nul
copy /Y "%MSYS_UCRT_BIN%\libgcc_s_seh-1.dll" "%APP_DIR%" >nul
copy /Y "%MSYS_UCRT_BIN%\libstdc++-6.dll" "%APP_DIR%" >nul
copy /Y "%MSYS_UCRT_BIN%\libwinpthread-1.dll" "%APP_DIR%" >nul

echo Runtime DLLs copied to %APP_DIR%
exit /b 0
