@echo off
echo Reiniciando...
nssm restart epsonFiscalDriver
timeout /nobreak 1

echo.
echo.

echo Estado del servicio:

nssm status epsonFiscalDriver


echo.
echo Presione Enter para salir
pause
