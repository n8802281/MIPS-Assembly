.data
msg1:	.asciiz "0613348 Lab1b, Enter the number n = "
msg2:	.asciiz " "
msg3:	.asciiz "*"
msg4:	.asciiz "\n"
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
f1:	addi $sp, $sp, -8		# adiust stack for 3 items
		sw $ra, 4($sp)				# save the return address
		sw $a0, 0($sp)				# save the argument n
		add $t9, $a0, $zero
		
		add $t1, $zero, $zero
		addi $t2, $t9, -1
Loop1:
		add $t3, $t9, $zero
		addi $t4, $t1, 0
		
		add $t5, $zero, $zero
		add $t6, $t9, $t1
		add $t6, $t6, $t1
Loop2:
		li      $v0, 4				# call system call: print string
		la      $a0, msg2			# load address of string into $a0
		syscall                 	# run the syscall
 		
 		addi $t3, $t3, -1
 		slt $t0, $t4, $t3
 		beq $t0, 1, Loop2
Loop3:	
		li      $v0, 4				# call system call: print string
		la      $a0, msg3			# load address of string into $a0
		syscall                 	# run the syscall

		addi $t5, $t5, 1
		slt $t0, $t5, $t6
		beq $t0, 1, Loop3
		
		li      $v0, 4				# call system call: print string
		la      $a0, msg4			# load address of string into $a0
		syscall                 	# run the 
		addi $t1, $t1, 1
		slt $t0, $t1, $t2
		beq $t0, 1 ,Loop1
		
		
		
		add $t1, $zero, $zero
		addi $t2, $t9, 0
Loop4:
		nor $t8, $t1, $zero
		add $t3, $t9, $t8
		addi $t4, $t9, 0
		
		add $t5, $zero, $zero
		add $t6, $t9, $t9
		add $t6, $t6, $t9
		add $t6, $t6, $t8
		add $t6, $t6, $t8

Loop5:
		li      $v0, 4				# call system call: print string
		la      $a0, msg2			# load address of string into $a0
		syscall                 	# run the syscall
 		
 		addi $t3, $t3, 1
 		slt $t0, $t3, $t4
 		beq $t0, 1, Loop5
Loop6:	
		li      $v0, 4				# call system call: print string
		la      $a0, msg3			# load address of string into $a0
		syscall                 	# run the syscall

		addi $t5, $t5, 1
		slt $t0, $t5, $t6
		beq $t0, 1, Loop6
		
		li      $v0, 4				# call system call: print string
		la      $a0, msg4			# load address of string into $a0
		syscall                 	# run the 
		addi $t1, $t1, 1
		slt $t0, $t1, $t2
		beq $t0, 1 ,Loop4
				
		jr $ra						# return to caller

