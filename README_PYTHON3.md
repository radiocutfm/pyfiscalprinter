# PyFiscalPrinter - Python 3

Drivers para impresoras fiscales (Epson & Hasar) - Argentina

## Status de Migración

✅ **Python 3 Compatible** - Migración completada con éxito

Todos los archivos han sido migrados a Python 3 y compilados correctamente.

## Versión Anterior

La versión original de Python 2 se puede encontrar en:
- El archivo `2to3.diff` contiene el diff inicial generado por 2to3
- El archivo `2to3.dry.diff` contiene una vista previa de los cambios

## Requisitos

- Python 3.6+
- pyserial

## Instalación

### Instalación Rápida
```bash
pip install pyserial
python3 setup.py install
```

### Instalación en Desarrollo
```bash
pip install pyserial
python3 setup.py develop
```

## Validación

Para verificar que todo está instalado correctamente:

```bash
# Compilación
python3 -m py_compile *.py

# Importación
python3 -c "from pyfiscalprinter import *; print('OK')"

# Test básico
python3 test.py --dummy
```

## Documentación Importante

Consulta los siguientes archivos para información detallada:

1. **[MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)**
   - Resumen completo de cambios realizados
   - Lista de archivos modificados
   - Cambios por categoría (imports, strings, excepciones, etc.)
   - Notas sobre bytes vs strings en comunicación serial

2. **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)**
   - Errores comunes y soluciones
   - Guía de diferencias Python 2 vs 3
   - Tests de validación

3. **[CAMBIOS_EPSONDRIVER.md](CAMBIOS_EPSONDRIVER.md)**
   - Análisis detallado de cambios en epsonFiscalDriver.py
   - Ejemplos de código antes/después
   - Explicación de por qué cada cambio fue necesario

## Cambios Principales

- ✅ Importaciones de módulos actualizadas
- ✅ Print statements convertidos a funciones
- ✅ Manejo de strings/unicode actualizado
- ✅ Excepciones con sintaxis `as` 
- ✅ Bytes/strings en comunicación serial optimizados
- ✅ Encoding `latin1` preservado para compatibilidad
- ✅ Todos los 10 archivos Python compilados correctamente

## Características

### Drivers Soportados
- Epson FX/LX/TMU (para tickets)
- Hasar (615, 715, 320)

### Funcionalidades
- Apertura de comprobantes fiscales
- Impresión de items
- Cálculo de IVA
- Cierre de comprobantes
- Consulta de últimos números
- Cierre diario (Z/X)

## Estructura del Proyecto

```
pyfiscalprinter/
├── __init__.py                    # Info del paquete
├── fiscalGeneric.py               # Interfaz base
├── epsonFiscal.py                 # Driver Epson
├── hasarPrinter.py                # Driver Hasar
├── epsonFiscalDriver.py           # Comunicación serial
├── controlador.py                 # Controlador principal
├── agente.py                      # Servidor HTTP
├── test.py                        # Script de prueba
├── setup.py                       # Setup de instalación
└── MIGRATION_SUMMARY.md           # Este documento
```

## Uso Básico

```python
from pyfiscalprinter import controlador

# Crear controlador
ctrl = controlador.PyFiscalPrinter()

# Conectar a impresora
ctrl.Conectar(marca='epson', modelo='epsonlx300+', puerto='COM1')

# Abrir comprobante
ctrl.AbrirComprobante(tipo_cbte=83)  # Ticket

# Agregar item
ctrl.ImprimirItem(ds='Producto', qty=1, importe=100.00, alic_iva=21)

# Agregar pago
ctrl.ImprimirPago(ds='Efectivo', importe=100.00)

# Cerrar comprobante
ctrl.CerrarComprobante()
```

## Compatibilidad

- ✅ Python 3.6+
- ⚠️ Python 2.x no soportado (usar rama legacy)
- ✅ Linux, Windows, macOS (con puerto serie USB o COM)

## Troubleshooting

### Error: `ModuleNotFoundError: No module named 'serial'`
```bash
pip install pyserial
```

### Error: `TypeError: expected bytes-like object`
Consulta [TROUBLESHOOTING.md](TROUBLESHOOTING.md#1-typeerror-expected-bytes-like-object)

### Error de Indentación
Consulta [TROUBLESHOOTING.md](TROUBLESHOOTING.md#5-problemas-de-indentación)

## Licencia

Ver archivo LICENSE

## Autores

- Guillermo Narvaja (autor original)
- Mariano Reingart (mantenedor)
- Migración a Python 3: Actualizado enero 2026

## Contacto

Para reportar bugs o solicitar features, consulta la documentación incluida.