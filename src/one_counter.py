binario = "1111-0100-0010-0011-1111"


binario_sin_separadores = binario.replace(" ", "").replace("-", "")
decimal = 0
for i in range(len(binario_sin_separadores)):
    bit = int(binario_sin_separadores[i])
    decimal += bit * 2**(len(binario_sin_separadores)-1-i)


print("El numero binario es: ", binario)
print("La longitud del numero binario es de: ", len(binario.replace(" ", "").replace("-", "")), "bits")
print("Donde el numero en decimal sin signo es: ", decimal)