class Transaccion:
    def __init__(self, id, tipo, monto):
        self.id = int(id)
        self.tipo = tipo.strip()  # limpiamos aquí
        self.monto = float(monto)