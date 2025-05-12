@echo off
setlocal EnableDelayedExpansion

REM Procura automaticamente o arquivo .sv com `timescale`
echo Procurando arquivo com '`timescale'...
for %%f in (*.sv) do (
    findstr /i "\`timescale" "%%f" >nul
    if !errorlevel! equ 0 (
        set fonte=%%f
        goto :found
    )
)

echo Nenhum arquivo com '`timescale' encontrado.
exit /b 1

:found
echo Arquivo top-level encontrado: %fonte%

REM Extrai o nome base do arquivo fonte (sem extensão)
for %%x in (%fonte%) do set basename=%%~nx
set basename=%basename:.sv=%

REM Define nome do arquivo de saída
set output=output_%basename%

REM Extrai nome do VCD a partir do $dumpfile(...)
set vcdfile=
for /f "tokens=2 delims=()" %%a in ('findstr /i "\$dumpfile(" %fonte%') do (
    set vcdfile=%%~a
)

REM Verifica se encontrou o dumpfile
if "%vcdfile%"=="" (
    echo Nenhuma diretiva $dumpfile encontrada em %fonte%.
    exit /b 1
)

REM Remove aspas do nome do VCD
set vcdfile=%vcdfile:"=%

REM Mostra os dados detectados
echo.
echo Fonte:       %fonte%
echo Executável:  %output%
echo Arquivo VCD: %vcdfile%

timeout /t 1 >nul
echo.
echo Compilando...
iverilog -g2012 -o %output% %fonte%

timeout /t 1 >nul
echo.
echo Executando simulação...
vvp %output%

timeout /t 1 >nul
echo.
echo Abrindo GTKWave com %vcdfile%...
gtkwave %vcdfile%