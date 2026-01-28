# Guía de Troubleshooting - Python 3 Migration

## Errores Comunes y Soluciones

### 1. ImportError: No module named 'serial'

**Causa:** La librería `pyserial` no está instalada

**Solución:**
```bash
pip install pyserial
```

### 2. TypeError: expected bytes-like object

**Causa:** Se está intentando comparar bytes con strings o viceversa

**Solución:** Verificar que las operaciones de lectura/escritura de puerto serie usen el tipo correcto.

En `epsonFiscalDriver.py`, los datos del puerto serie son **bytes** en Python 3:
```python
# ✓ Correcto
c = self._read(1)  # Retorna bytes
if c == b'\x02':
    pass

# ✗ Incorrecto
if c == chr(0x02):  # chr() devuelve string
    pass
```

### 3. UnicodeDecodeError al leer archivos

**Causa:** Encoding incorrecto al leer archivos de configuración

**Solución:** Especificar el encoding explícitamente:
```python
# ✓ Correcto
with open(filename, 'r', encoding='latin1') as f:
    data = f.read()

# ✗ Incorrecto
with open(filename, 'r') as f:
    data = f.read()  # Usa encoding por defecto del sistema
```

### 4. AttributeError: 'bytes' object has no attribute 'encode'

**Causa:** Intentar llamar `.encode()` en bytes

**Solución:** Verificar el tipo antes de codificar:
```python
# ✓ Correcto
if isinstance(data, str):
    data = data.encode('latin1')

# ✗ Incorrecto
data = data.encode('latin1')  # Puede fallar si data ya es bytes
```

### 5. Problemas de Indentación

**Causa:** Mezcla de tabs y espacios

**Solución:** Convertir todo a espacios (4 espacios por nivel):
```bash
# Convertir tabs a espacios en todos los archivos
python3 -m py_compile *.py  # Detecta errores
```

## Característica por Python

### Strings en Python 3

En Python 3, todos los strings son Unicode por defecto:

```python
# Python 2
s = "hello"  # bytes
u = u"hello"  # unicode

# Python 3
s = "hello"  # str (unicode)
b = b"hello"  # bytes
```

### Bytes en Python 3

Para trabajar con datos binarios (como en puerto serie):

```python
# Comparar bytes
data = port.read(1)
if data == b'\x02':  # Usar literal de bytes
    pass

# Convertir byte a int
byte_val = data[0]  # En Python 3, indexar bytes da int

# Crear byte desde int
b = bytes([0x02])
```

### Puertos Seriales

En Python 3, `pyserial.Serial.read()` devuelve **bytes**:

```python
port = serial.Serial('/dev/ttyUSB0')
data = port.read(1)  # Devuelve b'\x00' hasta b'\xff'
type(data)  # <class 'bytes'>

# Trabajar con bytes
if data[0] == 0x02:  # data[0] es int
    pass

if data == b'\x02':  # Comparación de bytes
    pass
```

## Validación Post-Migración

Ejecutar estos tests para validar la migración:

```bash
# 1. Compilación de todos los archivos
python3 -m py_compile *.py

# 2. Verificar imports
python3 -c "from pyfiscalprinter import *"

# 3. Verificar sintaxis específica
python3 -m ast *.py

# 4. Lint (opcional)
python3 -m pylint *.py --disable=all --enable=E
```

## Cambios de Comportamiento

### División Entera

```python
# Python 2
result = 5 / 2  # 2 (int)

# Python 3
result = 5 / 2  # 2.5 (float)
result = 5 // 2  # 2 (int floor division)
```

### Diccionarios

```python
# Python 2
items = d.items()  # list
values = d.values()  # list

# Python 3
items = list(d.items())  # iterator convertido a list
values = list(d.values())  # iterator convertido a list
```

### Filter/Map

```python
# Python 2
result = filter(lambda x: x > 2, [1,2,3])  # list

# Python 3
result = list(filter(lambda x: x > 2, [1,2,3]))  # iterator convertido a list
# O mejor
result = [x for x in [1,2,3] if x > 2]  # list comprehension
```

## Recursos Adicionales

- [Python 3 Documentation](https://docs.python.org/3/)
- [Python 2 to 3 Migration Guide](https://docs.python.org/3/howto/pyporting.html)
- [2to3 Tool Documentation](https://docs.python.org/3/library/2to3.html)
- [PySerial Documentation](https://pyserial.readthedocs.io/)
