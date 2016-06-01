.data
	wektorPorz1: .space 200
	wektorWar1: .space 200
	wektorPorz2: .space 200
	wektorWar2: .space 200
	rozmiar: .asciiz "Podaj rozmiar wektorow: (max. 25) "
	wartosci: .asciiz "Podaj wartosc: "
	
	pierwszy: .asciiz  "Podaj pierwszy wektor \n"
	drugi: .asciiz "Podaj drugi wektor \n"
	wyswietl: .asciiz "Wartosc iloczynu: "
	
.text
	# pytanie o rozmiar wektorow
	li $v0, 4
	la $a0, rozmiar
	syscall
	
	# pobranie rozmiaru
	li $v0, 5
	syscall
	move $s0, $v0
	
	addi $t0, $zero, 0 # ilosc podanych wartosci
	addi $t1, $zero, 0 # przesuniecie w wektorze porzadku (co 4)
	addi $t2, $zero, 0 # przesuniecie w wektorze wartosci (co 8)
	addi $s1, $zero, 1 # przechowuje 1 do wpisywania do wektora porz¹dku
	
	li $v0, 4
	la $a0, pierwszy
	syscall
		
	wartosci1:  
		beq $t0, $s0, dalej
		addi $t0, $t0, 1
		
		li $v0, 4
		la $a0, wartosci
		syscall
		
		li $v0, 7
		syscall
		c.eq.d $f0, $f2
		bc1f dodaj
		
		# wartosc = 0
		sw $zero, wektorPorz1($t1)
		addi $t1, $t1, 4
		j wartosci1
		
		# wartoœæ != 0
		dodaj:
			s.d $f0, wektorWar1($t2)
			addi $t2, $t2, 8
			sw $s1, wektorPorz1($t1)
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
		
		li $v0, 7
		syscall
		c.eq.d $f0, $f2
		bc1f dodaj2
		
		# wartosc = 0
		sw $zero, wektorPorz2($t1)
		addi $t1, $t1, 4
		j wartosci2
		
		# wartoœæ != 0
		dodaj2:
			s.d $f0, wektorWar2($t2)
			addi $t2, $t2, 8
			sw $s1, wektorPorz2($t1)
			addi $t1, $t1, 4
			j wartosci2
        
        iloczynSkalarny:
        		addi $t0, $zero, 0 # ktora z kolei wartosc
			addi $t1, $zero, 0 # przesuniecie w wektorze porzadku
			addi $t2, $zero, 0 # przesuniecie w wektorze wartosci1
			addi $t6, $zero, 0 # przesuniecie w wektorze wartosci2
			# $f10 aktualna wartosc iloczynu
		
			while:
				beq $t0, $s0, wynik
				lw $t4, wektorPorz1($t1)
				beq $t4, $zero, drugaWar
				l.d $f4, wektorWar1($t2)
				addi $t2, $t2, 8
			drugaWar: 
				lw $t5, wektorPorz2($t1)
				beq $t5, $zero, next
				l.d $f6, wektorWar2($t6)
				addi $t6, $t6, 8
				mul.d $f4, $f4, $f6
				add.d $f10, $f10, $f4
				
				next:
					mul.d $f4, $f4, $f8
					mul.d $f6, $f6, $f8
					addi $t1, $t1, 4
					addi $t0, $t0, 1
					j while
		
        	wynik:
        		li $v0, 4
        		la $a0, wyswietl
        		syscall
        		
        		mov.d $f12, $f10
        		
        		li $v0, 3
        		syscall
        		
    	exit:
 		li $v0, 10
       		syscall
			
