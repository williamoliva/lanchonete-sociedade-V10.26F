@echo off
REM Cria o atalho "Lanchonete Sociedade" na area de trabalho (com o icone do sistema).
REM Deixe este arquivo na mesma pasta do ABRIR-LANCHONETE.bat e de um clique duplo.
setlocal
set "ALVO=%~dp0ABRIR-LANCHONETE.bat"
set "ICONE=%~dp0icon.ico"
if not exist "%ALVO%" goto :erro
powershell -NoProfile -ExecutionPolicy Bypass -Command "$d=[Environment]::GetFolderPath('Desktop'); $s=(New-Object -ComObject WScript.Shell).CreateShortcut($d+'\Lanchonete Sociedade.lnk'); $s.TargetPath=$env:ALVO; $s.WorkingDirectory=(Split-Path $env:ALVO); $s.IconLocation=$env:ICONE; $s.Save()"
if errorlevel 1 goto :erro
echo.
echo Pronto! O atalho "Lanchonete Sociedade" foi criado na area de trabalho.
pause
goto :fim
:erro
echo.
echo Nao consegui criar o atalho. Faca manualmente: botao direito em
echo ABRIR-LANCHONETE.bat, Enviar para, Area de trabalho (criar atalho).
pause
:fim
endlocal
