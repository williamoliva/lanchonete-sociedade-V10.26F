@echo off
REM ==========================================================================
REM  LANCHONETE SOCIEDADE - abre o sistema em janela propria
REM
REM  Como usar:
REM   1. Deixe este arquivo na MESMA pasta do index.html.
REM   2. Use uma pasta sem espacos no caminho. Exemplo: C:\Lanchonete
REM   3. De dois cliques aqui. Para facilitar, crie um atalho na area de trabalho
REM      (botao direito do mouse, Enviar para, Area de trabalho).
REM
REM  IMPORTANTE: este arquivo usa um perfil proprio do navegador, guardado em
REM  %LocalAppData%\LanchoneteSociedade . Os dados do sistema ficam la.
REM  Abra SEMPRE por este arquivo. Se abrir o index.html direto no Chrome, o
REM  sistema vai aparecer vazio, porque o banco de dados e outro.
REM ==========================================================================
setlocal

REM --- Opcoes (1 = ligado, 0 = desligado) ---
REM  TELA_CHEIA: abre ja em tela cheia
REM  IMPRIMIR_DIRETO: imprime o cupom sem abrir a janela de impressao
set TELA_CHEIA=0
set IMPRIMIR_DIRETO=0

REM --- Procura o Chrome. Se nao achar, procura o Edge ---
set "NAVEGADOR="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "NAVEGADOR=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined NAVEGADOR if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "NAVEGADOR=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not defined NAVEGADOR if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "NAVEGADOR=%LocalAppData%\Google\Chrome\Application\chrome.exe"
if not defined NAVEGADOR if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" set "NAVEGADOR=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not defined NAVEGADOR if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" set "NAVEGADOR=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"

if not exist "%~dp0index.html" goto :semarquivo
if not defined NAVEGADOR goto :semnavegador

REM --- Monta o endereco do sistema e abre ---
set "PASTA=%~dp0"
set "URL=file:///%PASTA:\=/%index.html"
set "PERFIL=%LocalAppData%\LanchoneteSociedade"

set OPCOES=--no-first-run
if "%TELA_CHEIA%"=="1" set OPCOES=%OPCOES% --start-fullscreen
if "%IMPRIMIR_DIRETO%"=="1" set OPCOES=%OPCOES% --kiosk-printing

start "" "%NAVEGADOR%" %OPCOES% --user-data-dir="%PERFIL%" --app="%URL%"
goto :fim

:semarquivo
echo Nao encontrei o index.html nesta pasta.
echo Deixe este arquivo na mesma pasta do index.html.
pause
goto :fim

:semnavegador
echo Nao encontrei o Chrome nem o Edge neste computador.
echo Instale o Google Chrome e abra este arquivo de novo.
pause

:fim
endlocal
