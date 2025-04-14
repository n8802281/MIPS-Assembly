.data
msg1:	.asciiz "0613348 Lab1a, Enter the number n = "

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

		move $t0, $v0				# save return value in t0 (because v0 will be used by system call) 

# print the result of procedure factorial on the console interface
		move $a0, $t0			
		li $v0, 1					# call system call: print integer
		syscall 					# run the syscall
   
		li $v0, 10					# call system call: exit
  		syscall						# run the syscall

#------------------------- procedure factorial -----------------------------
# load argument n in a0, return value in v0. 
.text
f1:		addi $sp, $sp, -12		# adiust stack for 3 items
		sw $ra, 8($sp)				# save the return address
		sw $a0, 4($sp)				# save the argument n
		addi $t1, $a0, -1
		sw $t1, 0($sp)
		
		slti $t0, $a0, 1			# test for n < 1
		beq $t0, $zero, L1			# if n >= 1 go to L1
		
		addi $v0, $zero, 0			# return 0
		addi $sp, $sp, 12			# pop 2 items off stack
		jr $ra						# return to caller
L1:		
		addi $a0, $a0, -1			# n >= 1, argument gets (n-1)
		jal f1				# call factorial with (n-1)
		lw $t1, 0($sp)				# return from jal, restore argument n
		lw $a0, 4($sp)
		lw $ra, 8($sp)				# restore the return address

		add $t2, $t1, $a0
		sw $a0, 12($sp)
		sw $t2, 16($sp)
		addi $sp, $sp, 12			# adjust stack pointer to pop 2 items
		add $v0, $a0, $zero			# return n*factorial(n-1)
		jr $ra						# return to the caller
		