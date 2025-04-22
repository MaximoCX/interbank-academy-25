# Reto: Procesamiento de Transacciones desde un Archivo CSV

## Introducción

Este reto consiste en desarrollar una aplicación en Python que procese un archivo CSV con transacciones financieras. El objetivo es leer las transacciones, calcular el balance final, identificar la transacción de mayor monto y contar las transacciones de tipo "Crédito" y "Débito". Todo esto debe presentarse en un reporte final en la terminal.

## Instrucciones de Ejecución

1. **Instalación de dependencias:**
   Asegúrate de tener Python instalado en tu sistema. Luego, instala las dependencias necesarias ejecutando el siguiente comando:

   ```bash
   pip install -r requirements.txt
   Si no tienes el archivo requirements.txt, asegúrate de tener las librerías estándar de Python, como csv, ya incluidas en el entorno.
   ```

Asegúrate de que el archivo CSV de entrada (`../data.csv`) esté disponible en el directorio correspondiente.

## Enfoque y Solución

La solución se estructura en tres clases principales:

### 1. `Transaccion`

Representa una transacción con tres atributos: `id`, `tipo` (Crédito/Débito) y `monto`. Se asegura de que el tipo se limpie de espacios en blanco y que el monto sea un número flotante.

```python
class Transaccion:
    def __init__(self, id, tipo, monto):
        self.id = int(id)
        self.tipo = tipo.strip() # Limpiamos el tipo de transacción
        self.monto = float(monto) # Aseguramos que el monto sea un número flotante
```

### 2. `LectorCSV`

Esta clase contiene un método estático que lee el archivo CSV utilizando la librería `csv` de Python y crea instancias de la clase `Transaccion` a partir de cada fila del archivo.

```python
import csv
from models.transaccion import Transaccion

class LectorCSV:
    @staticmethod
    def leer_archivo(ruta_archivo):
        transacciones = []
        with open(ruta_archivo, "r", encoding="utf-8-sig") as archivo:
            lector = csv.DictReader(archivo)
            for fila in lector:
                transaccion = Transaccion(
                    int(fila['id']),
                    fila['tipo'],
                    float(fila['monto'])
                )
                transacciones.append(transaccion)
        return transacciones

```

### 3. `ProcesadorTransacciones`

Contiene la lógica para procesar las transacciones:

- `calcular_balance`: Calcula el balance final sumando los créditos y restando los débitos.
- `transaccion_mayor_monto`: Identifica la transacción con el mayor monto.
- `contar_transacciones`: Cuenta las transacciones de tipo "Crédito" y "Débito".

```python
class ProcesadorTransacciones:
    def __init__(self, transacciones):
        self.transacciones = transacciones

    def calcular_balance(self):
        balance = 0
        credito_count = 0
        debito_count = 0

        for t in self.transacciones:
            monto = t.monto
            tipo = t.tipo.strip()

            if tipo == "Crédito":
                balance += monto
                credito_count += 1
            elif tipo == "Débito":
                balance -= monto
                debito_count += 1

        return balance, credito_count, debito_count

    def transaccion_mayor_monto(self):
        return max(self.transacciones, key=lambda t: t.monto)

    def contar_transacciones(self):
        credito = sum(1 for t in self.transacciones if t.tipo.strip() == 'Crédito')
        debito = sum(1 for t in self.transacciones if t.tipo.strip() == 'Débito')
        return credito, debito
```

## Flujo del Programa

1.  **Lectura del archivo CSV:** El archivo CSV con las transacciones es leído utilizando la clase `LectorCSV`.
2.  **Procesamiento de las transacciones:** Se utilizan las clases `ProcesadorTransacciones` para calcular el balance, identificar la transacción de mayor monto y contar las transacciones de tipo "Crédito" y "Débito".
3.  **Generación del reporte:** Finalmente, se imprime un reporte en la terminal con el balance final, la transacción de mayor monto y el conteo de transacciones.

## Ejemplo de salida del programa:

```plaintext
Reporte de Transacciones

---

Balance Final: 325.00
Transacción de Mayor Monto: ID 3 - 200.00
Conteo de Transacciones: Crédito: 3 Débito: 2

```

## Estructura del Proyecto

El proyecto se organiza en las siguientes carpetas y archivos principales:

```bash
.
├── data.csv         # Archivo de entrada con las transacciones
├── main.py          # Script principal que ejecuta el programa
├── models/
│   └── transaccion.py # Definición de la clase Transaccion
├── services/
│   └── procesador.py  # Lógica para procesar las transacciones
├── utils/
│   └── lector_csv.py  # Lógica para leer el archivo CSV
└── requirements.txt # Dependencias del proyecto

```

## Conclusión

Este reto proporciona una solución clara y modular para procesar transacciones desde un archivo CSV, realizando cálculos y generando un reporte final. La implementación de clases separadas para la lectura del archivo, procesamiento de las transacciones y reporte permite un código limpio y fácil de mantener.
