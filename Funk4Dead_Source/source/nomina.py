class Empleado:
    def __init__(self, nombre, salario_base):
        self.nombre = nombre
        self.salario_base = salario_base

    def calcular_salario_neto(self):
        impuesto = self.salario_base * 0.15  # 15% de impuestos
        bonificacion = self.salario_base * 0.10  # 10% de bonificación
        return self.salario_base - impuesto + bonificacion

    def __str__(self):
        return f"{self.nombre} - Salario Neto: ${self.calcular_salario_neto():.2f}"

# Lista para almacenar empleados
empleados = []

# Agregar empleados
empleados.append(Empleado("Juan Pérez", 3000))
empleados.append(Empleado("Ana Gómez", 4500))
empleados.append(Empleado("Carlos Ruiz", 5200))
empleados.append(Empleado("Rodrigo Velasco", 120))

# Mostrar la nómina
print("Nómina de empleados:")
for empleado in empleados:
    print(empleado)