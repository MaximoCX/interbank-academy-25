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

