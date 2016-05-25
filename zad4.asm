.data
	wektorPorz1: .space 100
	wektorWar1: .space 100
	wektorPorz2: .space 100
	wektorWar2: .space 100
	rozmiar: .asciiz "Podaj rozmiar wektorow: "
	wartosci: .asciiz "Podaj wartosc: "
	
	pierwszy: .asciiz "Podaj wartosci pierwszego wektora \n"
	drugi: .asciiz "Podaj wartosci drugiego wektora \n"
	wyswietl: .asciiz "Wartosc iloczynu: "
	
.text

	main:
		# pytanie o rozmiar wektorow
		li $v0, 4
		la $a0, rozmiar
		syscall
	
		# pobranie rozmiaru
		li $v0, 5
		syscall
		move $s0, $v0
		
		addi $t0, $zero, 0 # ilosc podanych wartosci
		addi $t1, $zero, 0 # przesuniecie w wektorze porzadku
		addi $t2, $zero, 0 # przesuniecie w wektorze wartosci
	
		li $v0, 4
		la $a0, pierwszy
		syscall
			
		wartosci1: 
		
			beq $t0, $s0, dalej
			addi $t0, $t0, 1
		
			li $v0, 4
			la $a0, wartosci
			syscall
		
			li $v0, 5
			syscall
			move $t5, $v0
			bne $t5, $zero, dodaj
			
			# wartosc = 0
			sw $t5, wektorPorz1($t1)
			addi $t1, $t1, 4
			j wartosci1
		
			# wartoœæ != 0
			dodaj:
				sw $t5, wektorWar1($t2)
				addi $t2, $t2, 4
				addi $t3, $zero, 1
				sw $t3, wektorPorz1($t1)
				addi $t1, $t1, 4
				j wartosci1
	
		dalej:
			li $v0, 4
			la $a0, drugi
			syscall
					
			addi $t0, $zero, 0 # ilosc podanych wartosci
			addi $t1, $zero, 0 # przesuniecie w wektorze porzadku
			addi $t2, $zero, 0 # przesuniecie w wektorze wartosci
	
		wartosci2:  
			beq $t0, $s0, iloczynSkalarny
			addi $t0, $t0, 1
			li $v0, 4
			la $a0, wartosci
			syscall
		
			li $v0, 5
			syscall
			move $t5, $v0
			bne $t5, $zero, dodaj2
		
			# wartosc = 0
			sw $t5, wektorPorz2($t1)
			addi $t1, $t1, 4
			j wartosci2
		
			# wartoœæ != 0
			dodaj2:
				sw $t5, wektorWar2($t2)
				addi $t2, $t2, 4
				addi $t3, $zero, 1
				sw $t3, wektorPorz2($t1)
				addi $t1, $t1, 4
				j wartosci2
        
       	 	iloczynSkalarny:
        		addi $t0, $zero, 0 # ktora z kolei wartosc
			addi $t1, $zero, 0 # przesuniecie w wektorze porzadku
			addi $t2, $zero, 0 # przesuniecie w wektorze wartosci1
			addi $t6, $zero, 0 # przesuniecie w wektorze wartosci2
			addi $t3, $zero, 0 #aktualna wartosc iloczynu
		
			while:
				beq $t0, $s0, wynik
				lw $t4, wektorPorz1($t1)
				beq $t4, $zero, drugaWar
				lw $t4, wektorWar1($t2)
				addi $t2, $t2, 4
			drugaWar: 
				lw $t5, wektorPorz2($t1)
				beq $t5, $zero, next
				lw $t5, wektorWar2($t6)
				addi $t6, $t6, 4
				mul $t4, $t4, $t5
				add $t3, $t3, $t4
				
				next:
					addi $t4, $zero, 0
					addi $t5, $zero, 0
					addi $t1, $t1, 4
					addi $t0, $t0, 1
					j while
		
        		wynik:
        			li $v0, 4
        			la $a0, wyswietl
        			syscall
        		
        			li $v0, 1
        			add $a0, $t3, $zero
        			syscall
        		
    		exit:
 			li $v0, 10
       			syscall
			
