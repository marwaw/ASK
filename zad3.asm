.data
	array: .space 100
	ile: .asciiz "Ile liczb chcesz posortowac? " 
	podaj: .asciiz "Podaj liczbe: "
	space: .asciiz ", "

.text
	.main:		
		# ile liczb posortowac
		li $v0, 4
		la $a0, ile
		syscall
			
		li $v0, 5
		syscall
		# $s0 - rozmiar tablicy
		move $s0, $v0
		
		addi $t1, $zero, 0
		addi $t2, $zero, 0
			
		createArr:
			# wyświetlenie zapytania
			li $v0, 4
			la $a0, podaj
			syscall
		
			# pobranie wartości
			li $v0, 5
			syscall
			sw $v0, array($t1)
		
			addi $t1, $t1, 4
			addi $t2, $t2, 1
			
			bne $t2, $s0, createArr
    
    		jal sort
   
        	addi $t0, $zero, 0
        	addi $t1, $zero, 4
   		mul $t1, $s0, $t1
        
    		print:
        		beq $t0, $t1, exit
        		lw $t6, array($t0)
        		li $v0, 1
        		add $a0, $t6, $zero
        		syscall
        		li $v0, 4
        		la $a0, space
        		syscall
        		addi $t0, $t0, 4
        		j print
        
    		exit:
        		li $v0, 10
        		syscall

		sort:
			# $t0 - rozmiar do posortowania
   		# i- $t1
   		# j - $t2
   		addi $t0, $zero, 4
   		mul $t0, $s0, $t0 
   		addi $t1, $zero, 0 
    
   		loop:
        		beq $t1, $s0, back
        		addi $t1, $t1, 1
    			addi $t2, $zero, 0
    			sub $t0, $t0, 4
    			
        		while:
	          	 	beq $t2, $t0, loop
        	    		lw $t3, array($t2)
	            		addi $t2, $t2, 4
	           		lw $t4, array($t2)
	           		slt $t5, $t3, $t4
	            		bne $t5, $zero, while
	            		# swap
	            		sw $t3, array($t2)
	            		sub $t2, $t2, 4
	            		sw $t4, array($t2)
	            		add $t2, $t2, 4
	            		# end of swap
	            		j while
	            		
	        back:
	        	jr $ra
