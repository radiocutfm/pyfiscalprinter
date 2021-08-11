pyfiscalprinter
===============

Drivers for invoice/tickets fiscal printers (Epson &amp; Hasar) Argentina


# Construcción de instalador de servicio para windows

```
docker build --tag epsonfiscaldriver-wininstall -f windows/Dockerfile .
docker run -it --rm -v $PWD/dist:/output epsonfiscaldriver-wininstall
```

Va a construir un binario portable para el driver y generar un instalador del servicio utilizando Innosetup y NSSM.

# Construcción de instalador de servicio para linux

```
docker build --tag epsonfiscaldriver-linuxinstall -f linux/Dockerfile .
docker run -it --rm -v $PWD/dist:/output epsonfiscaldriver-linuxinstall
```

Va a construir un binario portable para el driver y generar un instalador del servicio utilizando makeself.
