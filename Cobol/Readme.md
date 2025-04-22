# README: REPORTE-TRANSACCIONES

## Descripción

Este programa COBOL procesa un archivo de texto que contiene transacciones de crédito y débito, calculando el saldo final, el monto máximo de una transacción y el conteo de transacciones de crédito y débito. El programa está diseñado para leer un archivo CSV, extraer los datos de las transacciones y generar un reporte con los resultados.

![image](https://github.com/user-attachments/assets/d93cf795-2013-4512-a4bc-23c50da2873c)

## Propósito

El programa fue desarrollado como parte de la Interbank COBOL Academy y su propósito es mostrar cómo trabajar con archivos secuenciales y procesar datos financieros en COBOL. Los resultados incluyen el saldo final de todas las transacciones, la transacción con el mayor monto y el número de transacciones de tipo crédito y débito.

## Requisitos

- **Cobol Compiler**: Este programa fue desarrollado utilizando el compilador `cobc` (OpenCOBOL).
- **Archivo de entrada**: El programa asume que existe un archivo de entrada llamado `data.csv` en formato CSV con las siguientes columnas:
  1. **ID de Transacción** (campo de 5 caracteres)
  2. **Tipo de Transacción** (campo de 10 caracteres, puede ser "Credito" o "Debito")
  3. **Monto de la Transacción** (campo numérico con 5 dígitos enteros y 2 decimales)

## Estructura del Programa

/reporte-transacciones
│
├── reporte-transacciones.cob # Código fuente COBOL del programa
├── data.csv # Archivo de entrada con las transacciones (debe estar en el mismo directorio)
└── README.md # Documentación de ejecución y descripción del proyecto

### 1. **Divisiones:**

- **IDENTIFICATION DIVISION**: Define el nombre del programa.
- **ENVIRONMENT DIVISION**: Define el archivo de entrada `data.csv` como un archivo de entrada secuencial.
- **DATA DIVISION**:
  - **FILE SECTION**: Declara la estructura del archivo de entrada.
  - **WORKING-STORAGE SECTION**: Declara las variables utilizadas durante el procesamiento de las transacciones (como el saldo, el ID de la transacción con el mayor monto, y los contadores de transacciones de crédito y débito).
- **PROCEDURE DIVISION**: Contiene el flujo principal del programa.

### 2. **Flujo del Programa:**

- **Abrir el archivo de entrada**: El archivo `data.csv` se abre en modo de solo lectura.
- **Lectura de transacciones**: El programa lee línea por línea el archivo de transacciones y procesa cada una.
- **Procesamiento de línea**: Para cada línea, el programa:
  - Divide la línea por el delimitador `,` en tres campos: ID, tipo y monto.
  - Convierte los valores a sus respectivos formatos (números y texto).
  - Actualiza el saldo, los contadores de transacciones y verifica si la transacción es la de mayor monto.
- **Reporte**: Al finalizar el procesamiento del archivo, el programa genera un reporte que incluye:
  - El balance final después de todas las transacciones.
  - La transacción con el mayor monto.
  - El número de transacciones de tipo "Credito" y "Debito".

### 3. **Manejo de Archivos y Datos:**

- El archivo `data.csv` debe estar disponible y debe tener el formato adecuado para que el programa funcione correctamente.
- El programa utiliza el delimitador `,` para separar los campos en cada línea del archivo.

### 4. **Salida:**

El reporte se muestra en la consola con el siguiente formato:

![image](https://github.com/user-attachments/assets/b803ee97-73d4-4463-a3be-8a7b3f9b106a)

