##############################################################################
# File: sort.s
# Skeleton for ECE 154A
##############################################################################

	.data
student:
	.asciiz "Yuki Keung\nMinh Bui\nHarshita Gangswamy" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciiz "\n"
	.globl nl
sort_print:
	.asciiz "[Info] Sorted values\n"
	.globl sort_print
initial_print:
	.asciiz "[Info] Initial values\n"
	.globl initial_print
read_msg: 
	.asciiz "[Info] Reading input data\n"
	.globl read_msg
code_start_msg:
	.asciiz "[Info] Entering your section of code\n"
	.globl code_start_msg

key:	.word 268632064			# Provide the base address of array where input key is stored(Assuming 0x10030000 as base address)
output:	.word 268632144			# Provide the base address of array where sorted output will be stored (Assuming 0x10030050 as base address)
numkeys:	.word 6				# Provide the number of inputs
maxnumber:	.word 10			# Provide the maximum key value


## Specify your input data-set in any order you like. I'll change the data set to verify
data1:	.word 1
data2:	.word 1
data3:	.word 1
data4:	.word 2
data5:	.word 2
data6:	.word 2

	.text

	.globl main
main:					# main has to be a global label
	addi	$sp, $sp, -4		# Move the stack pointer
	sw 	$ra, 0($sp)		# save the return address
			
	li	$v0, 4			# print_str (system call 4)
	la	$a0, student		# takes the address of string as an argument 
	syscall	

	jal process_arguments
	jal read_data			# Read the input data

	j	ready

process_arguments:
	
	la	$t0, key
	lw	$a0, 0($t0)
	la	$t0, output
	lw	$a1, 0($t0)
	la	$t0, numkeys
	lw	$a2, 0($t0)
	la	$t0, maxnumber
	lw	$a3, 0($t0)
	jr	$ra	

### This instructions will make sure you read the data correctly
read_data:
	move $t1, $a0
	li $v0, 4
	la $a0, read_msg
	syscall
	move $a0, $t1

	la $t0, data1
	lw $t4, 0($t0)
	sw $t4, 0($a0)
	la $t0, data2
	lw $t4, 0($t0)
	sw $t4, 4($a0)
	la $t0, data3
	lw $t4, 0($t0)
	sw $t4, 8($a0)
	la $t0, data4
	lw $t4, 0($t0)
	sw $t4, 12($a0)
	la $t0, data5
	lw $t4, 0($t0)
	sw $t4, 16($a0)
	la $t0, data6
	lw $t4, 0($t0)
	sw $t4, 20($a0)

	jr	$ra


counting_sort:
######################### 
## your code goes here ##
#########################
# pointers to input and output arrays stored in $a0 and $a1
# numkeys and maxnumber stored in $a2 and $a3

	addi $s7, $a3, 1		# s7 = maxnumber + 1
	sll $s7, $s7, 2			# s7 *= 4 (byte offset)
	sub $t0, $0, $s7		# t0 = 0 - s7
	add $sp, $sp, $t0		# allocate space on the stack for count 

	addi $t0, $0, 0 #declare n = 0
	addi $a3, $a3, 1
first_for:
	beq $t0, $a3, second_renew
	sll $t1, $t0, 2		#n*4 for byte offset
	add $t2, $sp, $t1	#t2 = count[n]
	sw $0, ($t2)		#count[n] = 0
	addi $t0, $t0, 1	#n++
	j first_for
second_renew:
	addi $t0, $0, 0
second_for:
	beq $t0, $a2, third_renew 
	sll $t1, $t0, 2 	#n*4 for byte offset
	add $t2, $a0, $t1 	#t2 = address of input
	lw $t3, ($t2) 		#t3 = keys[n]
	sll $t3, $t3, 2 	#get the address of the current integer
	add $t2, $sp, $t3 	#t2 = address of count[keys[n]]
	lw $t3, ($t2)		#t3 = count[keys[n]]
	addi $t3, $t3, 1 	#count[keys[n]]++
	sw $t3, ($t2)		#restore count[keys[n]]
	addi $t0, $t0, 1	#n++
	j second_for
third_renew:
	addi $t0, $0, 1
third_for:
	beq $t0, $a3, last_renew 
	sll $t1, $t0, 2 	#n*4 for byte offset
	add $t1, $sp, $t1 	#address of count[n]
	lw $t2, ($t1) 		#get word at count[n]
	lw $t3, -4($t1) 	#get word at count[n-1]
	add $t2, $t2, $t3 	#add count[n] and count[n-1]
	sw $t2, ($t1) 		#count[n] = count[n] + count[n-1]
	addi $t0, $t0, 1	#n++
	j third_for
last_renew:
	addi $t0, $0, 0
last_for:
	beq $t0, $a2, done	 
	sll $t1, $t0, 2 	#byte offset
	add $t2, $t1, $a0 	#get address of keys[n]
	lw $t3, ($t2) 		#t3 = keys[n]
	sll $t4, $t3, 2 	#byte offset for keys[n]
	add $t4, $sp, $t4	#address of count[keys[n]]
	lw $t5, ($t4)		#t5 = count[keys[n]]
	addi $t5, $t5, -1	#t5 = count[keys[n]]-1
	sll $t6, $t5, 2		#t5*4 for byte addressing
	add $t7, $t6, $a1	#address output[count[keys[n]]-1]
	sw $t3, ($t7)		#store keys[n] -> output[count[keys[n]]-1]
	sw $t5, ($t4)		#store output[keys[n]]-- -> output[keys[n]] 
	addi $t0, $t0, 1	#n++
	j last_for
done:
	add $sp,$sp,$s7
#########################
 	jr $ra
#########################


##################################
#Dont modify code below this line
##################################
ready:
	jal	initial_values		# print operands to the console
	
	move 	$t2, $a0
	li 	$v0, 4
	la 	$a0, code_start_msg
	syscall
	move 	$a0, $t2

	jal	counting_sort		# call counting sort algorithm

	jal	sorted_list_print


				# Usual stuff at the end of the main
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4
	jr	$ra			# return to the main program

print_results:
	add $t0, $0, $a2 # No of elements in the list
	add $t1, $0, $a0 # Base address of the array
	move $t2, $a0    # Save a0, which contains base address of the array

loop:	
	beq $t0, $0, end_print
	addi, $t0, $t0, -1
	lw $t3, 0($t1)
	
	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 4
	la $a0, nl
	syscall

	addi $t1, $t1, 4
	j loop
end_print:
	move $a0, $t2 
	jr $ra	

initial_values: 
	move $t2, $a0
        addi	$sp, $sp, -4		# Move the stack pointer
	sw 	$ra, 0($sp)		# save the return address

	li $v0,4
	la $a0,initial_print
	syscall
	
	move $a0, $t2
	jal print_results
 	
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4

	jr $ra

sorted_list_print:
	move $t2, $a0
	addi	$sp, $sp, -4		# Move the stack pointer
	sw 	$ra, 0($sp)		# save the return address

	li $v0,4
	la $a0,sort_print
	syscall
	
	move $a0, $t2
	
	#swap a0,a1
	move $t2, $a0
	move $a0, $a1
	move $a1, $t2
	
	jal print_results
	
    #swap back a1,a0
	move $t2, $a0
	move $a0, $a1
	move $a1, $t2
	
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4	
	jr $ra
