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
