pyfiscalprinter
===============

Drivers for invoice/tickets fiscal printers (Epson &amp; Hasar) Argentina


# Construcción de ejecutable

## Windows

```
docker run -it --rm -v $PWD:/src cdrx/pyinstaller-windows:python2
```

Genera `epsonFiscalDriver.exe` en `dist/windows`

## Linux

```
docker run -it --rm -v $PWD:/src cdrx/pyinstaller-linux:python2
```

Genera `epsonFiscalDrive` en `dist/linux`
