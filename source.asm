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