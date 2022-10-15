##############################################################################
# File: div.s
# Skeleton for ECE 154a project
# Skeleton Revision 2021-10-18.1
##############################################################################

	.data
student:
	.asciiz "Student" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciiz "\n"
	.globl nl


op1:	.word 7				# divisor for testing
op2:	.word 19			# dividend for testing


	.text

	.globl main
main:					# main has to be a global label
	addi	$sp, $sp, -4		# Move the stack pointer
	sw 	$ra, 0($sp)		# save the return address

	move	$t0, $a0		# Store argc
	move	$t1, $a1		# Store argv
				
	li	$v0, 4			# print_str (system call 4)
	la	$a0, student		# takes the address of string as an argument 
	syscall	

operands:
	la	$t0, op1
	lw	$a0, 0($t0)
	la	$t0, op2
	lw	$a1, 0($t0)
		

ready:
	jal	divide			# go to multiply code

	jal	print_result		# print operands to the console

					# Usual stuff at the end of the main
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4
	jr	$ra			# return to the main program


divide:
##############################################################################
# Your code goes here.
# Should have the same functionality as running
#	divu	$a1, $a0 dividend, divisor
#	mflo	$a2 quotient
#	mfhi	$a3 remainder
##############################################################################
addi $a3, $0, 0		#initialize $a3 - the remainder 
addi $a2, $0, 0		#initialize $a2 - the quotient 
or $t1, $a1, $0		#copy a1 to t1
or $t2, $a0, $0		#copy a0 to t2
div_start:
	slt $t4, $t1, $t2	#checking if dividend is smaller than divisor
	bne $t4, $0, done	#if t1 is bigger than t2 then go to done
	addi $a2, $a2, 1	#a2 = a2 + 1
	sub $t1, $t1, $t2	#t1 = t1 - t2
	j div_start
done: 
	add $a3, $0, $t1

##############################################################################
# Do not edit below this line
##############################################################################
	jr	$ra


# Prints $a0, $a1, $a2, $a3
print_result:
	move	$t0, $a0
	li	$v0, 4
	la	$a0, nl
	syscall

	move	$a0, $t0
	li	$v0, 1
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a1
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a2
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a3
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	jr $ra
