##############################################################################
# File: mult.s
# Skeleton for ECE 154a project
# Skeleton Revision 2021-10-18.1
##############################################################################

	.data
student:
	.asciiz "Student" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciiz "\n"
	.globl nl


op1:	.word 2				# change the multiplication operands
op2:	.word 9			# for testing.


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
	jal	multiply		# go to multiply code

	jal	print_result		# print operands to the console

					# Usual stuff at the end of the main
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4
	jr	$ra			# return to the main program


multiply:
##############################################################################
# Your code goes here.
# Should have the same functionality as running
#	multu	$a1, $a0
#	mflo	$a2
	# $a0 = multiplicand, $a1 = multiplier, $a2 = product
	addi $s0, $0, 0 	# $s0 = 0 for loop
	addi $s1, $0, 8 	# $s1 = 8 for loop
	addi $a2, $0, 0		# $a2 = product 
	addi $s2, $a1, 0 	# $s2 = $a1 = multiplier
	addi $s3, $a0, 0	# $s3 = $a0 = multiplicand
	j for
	
for:
	beq $s0, $s1, done 	# if i == 8, branch to done
	andi $s4, $s2, 1	# $s4 =  multiplier[0]
	bne $s4, 1, shift 	# if multiplier[0] == 0, branch to shift
	add $a2, $a2, $s3	# multiplier[0] == 1, add multiplicand to product
	j shift

shift:
	sll $s3, $s3, 1		# $s2 = new shifted multiplicand (shifted left by 1)
	srl $s2, $s2, 1		# $s3 = new shifted multiplier (shifted right by 1)
	addi $s0, $s0, 1 	# increment i
	j for

done:
##############################################################################


##############################################################################
# Do not edit below this line
##############################################################################
	jr	$ra



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

	jr $ra
