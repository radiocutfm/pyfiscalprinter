# Cambios Críticos en epsonFiscalDriver.py

## Resumen

El archivo `epsonFiscalDriver.py` contiene la lógica de comunicación serial más compleja. En Python 3, esto requiere especial atención ya que los datos del puerto serie son **bytes**, no strings.

## Cambios Principales

### 1. Método `_write()` y `_read()`

**Antes (Python 2):**
```python
def _write( self, s ):
    if isinstance(s, unicode):
        s = s.encode("latin1")
    debug( "_write", ", ".join( [ "%x" % ord(c) for c in s ] ) )
    self._serialPort.write( s )

def _read( self, count ):
    ret = self._serialPort.read( count )
    debug( "_read", ", ".join( [ "%x" % ord(c) for c in ret ] ) )
    return ret
```

**Después (Python 3):**
```python
def _write( self, s ):
    if isinstance(s, str):
        s = s.encode("latin1")
    debug( "_write", ", ".join( [ "%x" % (b if isinstance(b, int) else ord(b)) for b in s ] ) )
    self._serialPort.write( s )

def _read( self, count ):
    ret = self._serialPort.read( count )
    debug( "_read", ", ".join( [ "%x" % (b if isinstance(b, int) else ord(b)) for b in ret ] ) )
    return ret
```

**Razón:** En Python 3, `pyserial` devuelve bytes. Cuando iteras sobre bytes, obtienes integers directamente, no caracteres.

### 2. Método `_sendMessage()` - Comparaciones de Bytes

**Antes (Python 2):**
```python
if ord(c) in (0x12, 0x14): # DC2 o DC4
    timeout += self.WAIT_TIME
    continue

if c == chr(0x02):  # STX - Comienzo
    ...
    while c != chr(0x03):  # ETX
        ...
```

**Después (Python 3):**
```python
byte_val = c[0] if isinstance(c, bytes) else ord(c)
if byte_val in (0x12, 0x14): # DC2 o DC4
    timeout += self.WAIT_TIME
    continue

stx_byte = b'\x02' if isinstance(c, bytes) else chr(0x02)
if c == stx_byte:  # STX - Comienzo
    ...
    etx_byte = b'\x03' if isinstance(c, bytes) else chr(0x03)
    while c != etx_byte:  # ETX
        ...
```

**Razón:** En Python 3, los bytes del puerto serie no son comparables directamente con `chr()`. Necesitamos usar literales de bytes (`b'\x02'`) o detectar el tipo.

### 3. Método `_checkReplyBCC()`

**Antes (Python 2):**
```python
def _checkReplyBCC( self, reply, bcc ):
    debug( "reply", reply, [ord(x) for x in reply] )
    checkSum = sum( [ord(x) for x in reply ] )
    ...
    return checkSumHexa == bcc.upper()
```

**Después (Python 3):**
```python
def _checkReplyBCC( self, reply, bcc ):
    reply_vals = [b if isinstance(b, int) else ord(b) for b in reply]
    debug( "reply", reply, reply_vals )
    checkSum = sum( reply_vals )
    ...
    bcc_str = bcc.upper() if isinstance(bcc, str) else bcc.decode().upper()
    return checkSumHexa == bcc_str
```

**Razón:** 
- Los bytes en Python 3 al iterarse devuelven integers
- El BCC puede venir como string o bytes, necesitamos manejar ambos casos

### 4. Constantes de `HasarFiscalDriver`

**Antes (Python 2):**
```python
ACK = chr(0x06)
NAK = chr(0x15)
STATPRN = chr(0xa1)
```

**Después (Python 3):**
```python
ACK = b'\x06'
NAK = b'\x15'
STATPRN = b'\xa1'
```

**Razón:** Usar literales de bytes es más claro y evita confusiones con strings.

### 5. Método `sendCommand()`

**Antes (Python 2):**
```python
message = chr(0x02) + chr( self._sequenceNumber ) + chr(commandNumber)
if fields:
    message += chr(0x1c)
message += chr(0x1c).join( fields )
message += chr(0x03)
checkSum = sum( [ord(x) for x in message ] )
```

**Después (Python 3):**
```python
message = chr(0x02) + chr( self._sequenceNumber ) + chr(commandNumber)
if fields:
    message += chr(0x1c)
message += chr(0x1c).join( fields )
message += chr(0x03)
checkSum = sum( [ord(x) if isinstance(x, str) else x for x in message ] )
```

**Razón:** Cuando construimos el mensaje como string, los valores son strings. Necesitamos convertir a int solo los que son strings.

## Testing

Para verificar que estos cambios funcionan correctamente:

```python
# Test de comparación de bytes
c = b'\x02'
if c == b'\x02':
    print("✓ Comparación de bytes funciona")

# Test de indexación de bytes
data = b'\x06\x15\xaa'
for byte_val in data:
    print(f"Byte: {hex(byte_val)}")  # byte_val es int

# Test de puerto serie (requiere pyserial)
import serial
port = serial.Serial('/dev/ttyUSB0')
c = port.read(1)
if isinstance(c, bytes):
    print("✓ pyserial devuelve bytes en Python 3")
```

## Compatibilidad

El código actual mantiene compatibilidad con ambos strings y bytes en algunas funciones usando `isinstance()`. Esto permite que el código sea más robusto aunque sea ligeramente más complejo.

## Referencias

- [Python 3 Bytes and Bytearray Objects](https://docs.python.org/3/library/stdtypes.html#bytes)
- [PySerial Documentation](https://pyserial.readthedocs.io/)
- [chr() vs bytes() en Python 3](https://docs.python.org/3/library/functions.html#chr)
