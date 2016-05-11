.data
	pytanie: .asciiz "Podaj liczbe, ktorej silnie mam obliczyc: "
	wynik: .asciiz "Wynik: "

.text
	# $s0 - zawiera liczb�, kt�rej silni� liczymy 
	# $t0 - "licznik" obrot�w p�tli
	# $t1 - aktualna wartosc silni
	
    main:
	# wy�wietlenie zapytania
	li $v0, 4
	la $a0, pytanie
	syscall
	
	# pobranie warto�ci
	li $v0, 5
	syscall
	move $s0, $v0
	
	addi $t0, $zero, 1
	add $t1, $zero, $t0
	
	for:
	    beq $t0, $s0, exit
	    addi $t0, $t0, 1
	    mul $t1, $t0, $t1
	    j for
	    
	exit:
 	    li $v0, 4
 	    la $a0, wynik
 	    syscall
 	    
 	    li $v0, 1
 	    add $a0, $t1, $zero
 	    syscall
 	    
 	li $v0, 10
 	syscall
 	    
	    
	
	
	
	

