.data	# mude os valores de array e coloque em size a quantidade de numeros que tiver posto em array para testar
space: .asciiz " "		# uma String com um espa�o
array: .word 7,2,5,9,15,1	# array a ser ordenado
size: .word 6			# numero de inteiros no array

.text
.globl main
main:
la $t0, array	# array que ira ser ordenado
lw $t1, size	# tamanho do array | var size
li $t2, 1	# index | var i

insert_sort_start:
la $t0, array			# carrega o endere�o do array em $t0
bge $t2, $t1, print_array	# mantem o loop enquanto o size for maior que o index | while (i <= size)
move $t3, $t2 			# copia o valor de $t2 para $t3 | $t3 = var j

insert_sort_inside:
la $t0, array			# carrega o endere�o do array em $t0
sll $t5, $t3, 2			# multiplica o valor de $t3 por 4, e salva em $t5. Assim  podemos acessar os endere�os do array
add $t0, $t0, $t5		# soma o valor de $t5 no endere�o de $t0. $t0 � onde est� localizado o array
ble $t3, $zero, insert_sort_end # enquanto ( j <= size ), pulamos a execu�ao para a fun��o insert_sort_end
lw $t7, 0($t0)			# carrega o $t7 com o valor do endere�o 0($t0) | carrega o $t7 com o valor do array[j]
lw $t6, -4($t0)			# carrega o $t6 com o valor do endere�o -4($t0) | carrega o $t6 com o valor do array[j-1]
bge $t7, $t6, insert_sort_end	# while (array[j] >= array[j-1]), pulamos a execu�ao para a fun��o insert_sort_end
lw $t4, 0($t0)			# carrega o valor de 0($t0) em $t4 | carrega o valor de array[j] em $t4
sw $t6, 0($t0)			# salva o valor de $t6 no endere�o de 0($t0) | salva o valor de $t6 em array[j]
sw $t4, -4($t0)			# salva o valor de $t4 no endere�o de -4($t0) | salva o valor de $t4 em array[j-1]
subi $t3, $t3, 1		# subtrai j por 1 | j = j - 1
j insert_sort_inside		# retorna a execu��o para o come�o da fun��o atual

insert_sort_end:
addi $t2, $t2, 1		# soma i por 1 | i = i + 1
j insert_sort_start		# retorna a execu��o para a fun��o insert_sort

print_array:
la $t0, array	# array que ira ser ordenado
lw $t1, size	# tamanho do array | var size
li $t2, 0	# carrega o valor 0 em $t2, que sera o index do loop abaixo

print_array_inside:
bge $t2, $t1, end	# faz o loop para printar cada inteiro no array | while ( i <= size)
li $v0, 1		# codigo para printar um inteiro carregado na variavel $a0
lw $a0, 0($t0)		# carrega o primeiro valor do endere�o do array em $a0
syscall			# executa a chamado do SO
li $v0, 4		# codigo para printar uma String carregada em $a0
la $a0, space		# carrega space em $a0
syscall			# executa a chamada do SO
addi $t0, $t0, 4	# soma 4 no endere�o de $t0
addi $t2, $t2, 1	# soma 1 em $t2 
j print_array_inside	# retorna a execu��o para o come�o da fun��o atual
	
end:
li $v0, 10	# codigo para encerrar o programa
syscall		# executa a chamada do SO para encerrar o programa
