pyfiscalprinter
===============

Drivers for invoice/tickets fiscal printers (Epson &amp; Hasar) Argentina


# Construcción de instalador de servicio para windows

```
docker build --tag epsonFiscalDriver-wininstall -f windows/Dockerfile .
docker run -it --rm -v $PWD/dist:/output epsonFiscalDriver-wininstall
```

Va a construir un binario portable para el driver y generar un instalador del servicio utilizando Innosetup y NSSM.
