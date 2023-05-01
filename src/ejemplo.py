def comprimir(fila):
    nueva_fila = [num for num in fila if num != 0]
    while len(nueva_fila) < len(fila):
        nueva_fila.append(0)
    return nueva_fila

def fusionar(fila):
    for i in range(len(fila) - 1):
        if fila[i] == fila[i+1]:
            fila[i] *= 2
            fila[i+1] = 0
    return fila

def mover_hacia_arriba(tablero):
    for columna in range(len(tablero)):
        fila = [tablero[fila][columna] for fila in range(len(tablero))]
        fila_comprimida = comprimir(fila)
        fila_fusionada = fusionar(fila_comprimida)
        fila_actualizada = comprimir(fila_fusionada)

        for fila in range(len(tablero)):
            tablero[fila][columna] = fila_actualizada[fila]

    return tablero

# Ejemplo de uso:
tablero = [
    [2, 2, 4, 4],
    [2, 2, 4, 4],
    [0, 0, 4, 0],
    [0, 0, 3, 0]
]

tablero_actualizado = mover_hacia_arriba(tablero)
for fila in tablero_actualizado:
    print(fila)
