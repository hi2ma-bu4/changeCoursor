@echo off
setlocal


echo. �J�[�\���̎�ނ�I��
echo.1. �f�t�H���g
echo.2. �^�L�I��
echo.3. �J�t�F
echo.4. �e�C�I�[
echo.

choice /C 1234

Set ch=%ERRORLEVEL%

if %ch%==2 (
    Set dirName=�A�O�l�X�^�L�I��
    Set themeName='�^�L�I���J�[�\��^(�A�j���[�V����^)'
) else if %ch%==3 (
    Set dirName=�}���n�b�^���J�t�F
    Set themeName='�J�t�F�J�[�\��^(�A�j���[�V����^)'
) else if %ch%==4 (
    Set dirName=�g�E�J�C�e�C�I�[
    Set themeName='�e�C�I�[�J�[�\��^(�A�j���[�V����^)'
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
