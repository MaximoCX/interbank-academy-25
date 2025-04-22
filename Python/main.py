from utils.lector_csv import LectorCSV
from services.procesador import ProcesadorTransacciones

def main():
    ruta_archivo = '../data.csv'  

    transacciones = LectorCSV.leer_archivo(ruta_archivo)
    procesador = ProcesadorTransacciones(transacciones)

    mayor_transaccion = procesador.transaccion_mayor_monto()
    balance, credito_count, debito_count = procesador.calcular_balance()

    print("Reporte de Transacciones")
    print("---------------------------------------------")
    print(f"Balance Final: {balance:.2f}")
    print(f"Transacción de Mayor Monto: ID {mayor_transaccion.id} - {mayor_transaccion.monto:.2f}")
    print(f"Conteo de Transacciones: Crédito: {credito_count} Débito: {debito_count}")

if __name__ == '__main__':
    main()
