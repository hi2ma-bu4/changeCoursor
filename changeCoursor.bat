@echo off
setlocal


echo. カーソルの種類を選択
echo.1. デフォルト
echo.2. タキオン
echo.3. カフェ
echo.4. テイオー
echo.

choice /C 1234

Set ch=%ERRORLEVEL%

if %ch%==2 (
    Set dirName=アグネスタキオン
    Set themeName='タキオンカーソル^(アニメーション^)'
) else if %ch%==3 (
    Set dirName=マンハッタンカフェ
    Set themeName='カフェカーソル^(アニメーション^)'
) else if %ch%==4 (
    Set dirName=トウカイテイオー
    Set themeName='テイオーカーソル^(アニメーション^)'
) else (
    Set dirName=
    Set themeName=
)

powershell -NoProfile -ExecutionPolicy Unrestricted ".\changeMouseCursor.ps1 %dirName% %themeName%"

if not "%ERRORLEVEL%"=="0" (
    pause
)
endlocal
exit /b 0
