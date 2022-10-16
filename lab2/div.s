##############################################################################
# File: div.s
# Skeleton for ECE 154a project
# Skeleton Revision 2021-10-18.1
##############################################################################

	.data
student:
	.asciiz "Minh Bui, Harshita Gangaswamy, Yuki Keung" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciiz "\n"
	.globl nl


op1:	.word 4				# divisor for testing
op2:	.word 20			# dividend for testing


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
#	divu	$a1, $a0
#	mflo	$a2
#	mfhi	$a3

# $a0 = divisor, $a1 = dividend, $a2 = quotient, $a3 = remainder
	addi $s0, $a0, 0 	# $s0 = divisor
	addi $s1, $0, 0 	# $s1 = 0 for loop
	addi $s2, $0, 9 	# $s2 = 9 for loop
	addi $a2, $0, 0		# $a2 = quotient
	addi $a3, $a1, 0	# $a3 = remainder 
	sll $s0, $s0, 8		# shift divisor left 8 bits
	
for:
	beq $s1, $s2, done 	# if i == 9, branch to done
	sub $a3, $a3, $s0 	# remainder = remainder - divisor
	slt $s4, $a3, $0	# remainder >= 0, branch to else
	beq $s4, $0, else
	add $a3, $a3, $s0	# remainder < 0, remainder = remainder + divisor
	sll $a2, $a2, 1		# shift quotient left by 1, set rightmost bit of quotient to 0
	j shift	

else:
	sll $a2, $a2, 1		# remainder >= 0, shift quotient left by 1 bit
	ori $a2, $a2, 1		# set rightmost bit of quotient to 1	

shift: 
	srl $s0, $s0, 1		# shift divisor right by 1 bit
	addi $s1, $s1, 1	# increment i
	j for

done:
##############################################################################


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
