.data
prompt: .asciiz "Enter a number N (N >= 25): "
invalid_msg: .asciiz "Illegal Number!\n"
fib_msg: .asciiz "The Fibonacci sequence:\n"
comma: .asciiz ","

.text
.globl main

# Function to print a string
print_string:
    li $v0, 4               # System call for print_str (code 4)
    syscall
    jr $ra                  # Return

# Function to read an integer from console
read_int:
    li $v0, 5               # System call for read_int (code 5)
    syscall
    jr $ra                  # Return

# Main program
main:
    # Step 1: Prompt user for input
    la $a0, prompt          # Load address of the prompt
    jal print_string        # Print the prompt

    # Read integer N from user
input_loop:
    jal read_int            # Read user input
    move $t0, $v0           # Store N in $t0

# Check if N is legal (N >= 25)
    li $t1, 25              # Load 25 into $t1
    blt $t0, $t1, illegal   # If N < 25, branch to illegal

    # N is legal, proceed to Step 2
    j fibonacci_sequence    # Jump to calculate Fibonacci sequence

illegal:
    # Print error message for illegal number
    la $a0, invalid_msg     # Load address of the error message
    jal print_string        # Print the error message

    la $a0, prompt     # Load address of the prompt message
    jal print_string        # Print the error message

    j input_loop            # Repeat input loop

fibonacci_sequence:
    # Step 2: Print the first N numbers in the Fibonacci sequence
    li $t2, 0               # Initialize fib(0) = 0
    li $t3, 1               # Initialize fib(1) = 1
    li $t4, 2               # Initialize counter at 2 (already printed 0 and 1)

    # Print 0 and 1 separately
    la $a0, fib_msg         # Load address of Fibonacci message
    jal print_string        # Print the message

    li $v0, 1               # Print 0
    move $a0, $t2
    syscall

    la $a0, comma	    # Prints a comma between 0 and 1
    jal print_string

    li $v0, 1               # Print 1
    move $a0, $t3
    syscall

fib_loop:
    bge $t4, $t0, end_fib   # If counter >= N, end Fibonacci sequence

    add $t5, $t2, $t3       # Calculate fib(n) = fib(n-1) + fib(n-2)

    la $a0, comma	    # Prints a comma between numbers
    jal print_string