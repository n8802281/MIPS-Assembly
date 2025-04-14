.data
msg1:	.asciiz "0613348 Lab1c, Enter the number n = "
msg2:	.asciiz " is a prime"
msg3:	.asciiz " is not a prime, the nearest prime is"
msg4:	.asciiz " "

.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
 
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a0, $v0      		# store input in $a0 (set arugument of procedure factorial)

# jump to procedure factorial
  		jal f1

		li $v0, 10					# call system call: exit
  		syscall						# run the syscall

#------------------------- procedure factorial -----------------------------
# load argument n in a0, return value in v0. 
.text
f1:		
		addi $sp, $sp, -8		# adiust stack for 3 items
		sw $ra, 4($sp)				# save the return address
		sw $a0, 0($sp)
		add $t1, $a0, $zero
		add $t8, $t1, $zero
		jal prime
		beq $t9, 1, exit1
		
		lw $a0, 0($sp)
		li $v0, 1					
		syscall
		li      $v0, 4				# call system call: print string
		la      $a0, msg3			# load address of string into $a0
		syscall                 	# run the syscall
		
		addi $t2, $zero, 1
		j findingloop
		
findingloop:	

		sub $t8, $t1, $t2
		jal prime 
		add $t6, $zero, $t9

		add $t8, $t1, $t2
		jal prime
		add $t5, $zero, $t9
		

		
		or $t0, $t5, $t6
		beq $t0, 1 ,exit2
		addi $t2, $t2, 1
		j findingloop
exit1:		
		lw $ra, 4($sp)
		lw $a0, 0($sp)
	
		li $v0, 1					
		syscall
		li      $v0, 4				# call system call: print string
		la      $a0, msg2			# load address of string into $a0
		syscall                 	# run the syscall
		addi $sp, $sp, 8
		jr $ra
	
exit2: 
		beq $t6, 1, print2
		beq $t5, 1, print1

		lw $ra, 4($sp)
		lw $a0, 0($sp)
		addi $sp, $sp, 8
		jr $ra
	
print1:		
		li      $v0, 4				# call system call: print string
		la      $a0, msg4			# load address of string into $a0
		syscall
		add $t5, $t1, $t2
		add $a0, $t5, $zero
		li $v0, 1					
		syscall 		
		add $t5, $zero, $zero
		j exit2
print2:		
		li      $v0, 4				# call system call: print string
		la      $a0, msg4			# load address of string into $a0
		syscall
		sub $t6, $t1, $t2	
		add $a0, $t6, $zero
		li $v0, 1					
		syscall 	
		add $t6, $zero, $zero	
		j exit2		
		
prime:
		add $t7, $t8, $zero
		add $t9, $zero, $zero
		slti $t0, $t7, 2
		beq $t0, 1, pexit0
		addi $t3, $zero, 2
		j ploop
ploop:
		div $t8, $t3
		mfhi $t4 
		beq $t4, 0, pexit0
		addi $t3, $t3, 1
		mul $t4, $t3, $t3
		slt $t0, $t8, $t4
		beq $t0, 0, ploop
		j pexit1
		
pexit0:		jr $ra						# return to the caller
pexit1:		
		addi $t9, $zero, 1 
		jr $ra