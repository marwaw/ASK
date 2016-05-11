.data
	ileObrotow: .asciiz "Ile obrotow petli mam wykonac?: "
	czyDalej: .asciiz "Czy chcesz liczyc dalej? 1- tak, 0 - nie "
	wynik: .asciiz "Wynik: "

.text
	# $s0 - zawiera liczbê obroów pêtli, które nale¿y wykonac 
	# $t0 - "licznik" obrotów pêtli
	# $t1 - aktualna wartosc silni
	
	# 2147483648
	
	main:
	# pytanie o wartosc i pobranie jej 
         jal ile
         
	 addi $t0, $zero, 1
	 add $t1, $zero, $t0
	    
	 while:
	    beq $t0, $s0, next
	    addi $t0, $t0, 1
	    mulo $t1, $t0, $t1
	    j while
	   
	 next:	
	    li $v0, 4
	    la $a0, czyDalej
	    syscall
	       
	    li $v0, 5
	    syscall
	    move $t2, $v0
	       
	    beq $t2, $zero, exit
	    jal ile
	    j while
 	    
 	li $v0, 10
 	syscall
 	
 	ile:
	    # wyœwietlenie zapytania
            li $v0, 4
	    la $a0, ileObrotow
	    syscall
	    
	    # pobraanie wartoœci
	    li $v0, 5
	    syscall
	    add $s0, $s0, $v0
	    
	    jr $ra
	    
        exit:
            li $v0, 4
 	    la $a0, wynik
 	    syscall
 	    
 	    li $v0, 1
 	    add $a0, $t1, $zero
 	    syscall
	
    
