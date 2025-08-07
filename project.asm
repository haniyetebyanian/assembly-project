.data
instr_input: .space 100 
matrix_data: .space 40000 # 100 * 100 * 4 : matrix
data_name: .space 1200 # name
money: .space 400
name_count: .space 4
new_line: .ascii "\n"
#poin_t: .ascii "."

.text
.globl main

# s0 for instruction_number : s0 must be unchangable
# s1 in roll i and gets us how many instruction we did : after each instruction must be pluse : s1++
# s3 is a unicode for instructions
# s4 in roll index of the name


# s5 in instruction (1) in roll where of the instruction string

# s6 in instruction (1) is first name index
# s7 in instruction (1) is second name index
# s8 in instruction (1) is money amount

# s9 in func find index is word cound


# 1 mohammad haniye 10


#1 ali reza 10
#1 reza mohammad 5
#2
#3
#4 ali
#5 mohammad
#6 reza ali


main:

    li t0, 0
    la t1, name_count
    sw t0, 0(t1)

    li a7, 5
    ecall
    mv s0, a0
	
	li t1, 0
	mv s1, t1
	
for:	
    mv t0, s0
    mv t1, s1

	beq t0, t1, end # t1 is a survey like i in loop that must be <= instruction_number

	li a7, 8
	la a0, instr_input
	li a1, 100
	ecall
	
	la t2, instr_input # t0 point to the first of the instruction
	lb t1, 0(t2) # t1 is a content of the array(buffer) in t0 address
   

   li t0, '1'
   beq t1, t0, instr_1
   
   li t0, '2'
   beq t1, t0, instr_2
   
   li t0, '3'
   beq t1, t0, instr_3
   
   li t0, '4'
   beq t1, t0, instr_4
   
   li t0, '5'
   beq t1, t0, instr_5
   
   li t0, '6'
   beq t1, t0, instr_6


after_instru:  

	mv t1, s1
   	addi t1, t1, 1
	mv s1, t1
   
   	j for

instr_1:
# this instruction 1 s_1 s_2 x : s_1 gives s_2 x money => s_1 is a //todo and s_2 is a //todo
# if s_1 was exist and s_2 exist , we find them and then add x money to s_2 and sub x money from s_1 , then write x in matrix 
#    that shows us amout of money that gives and get in people
# if each of them doesn't exist we must write them in data then do others works


    addi t2, t2, 2 # jump to first lettle of the first name
    mv s5, t2 # move instruction location to s5

    li t0, 1
    mv s3, t0

    j find_index_name

    after_name_one_instru_1:


    mv s6, s4 
	
	
    mv t0, s5

    addi t0, t0, 1 # or two (2) please check
    mv s5, t0

    li t0, 2
    mv s3, t0


    j find_index_name

    after_name_two_instru_1:


    mv s7, s4

    mv t0, s5
    addi t0, t0, 1 # like up
    mv s5, t0

    li t0, 1
    mv s3, t0

    j make_money_from_string

    after_make_money:

    mv s2, t2

    j write_in_matrix


    after_writing_in_matrix:

    j after_instru

instr_2:

    li t0, 2
    mv s3, t0

    li t0, 0
    mv s5, t0

    j find_max

    after_find_max_instru_2:

    mv t0, s4

    li t1, -1

    li t2, 2
    mv s3, t2

    beq t0, t1, print_myness_one

    li t2, 2
    mv s3, t2 

    j find_better_one

    after_find_better_instru_2:

    j print_name

    after_printting_name_instru_2:

    after_printting_myness_one_instru_2:

    j after_instru
instr_3:

    li t0, 3
    mv s3, t0

    li t0, 0
    mv s5, t0

    j find_min

    after_find_min_instru_3:

    mv t0, s4

    li t1, 1
    li t2, 0
    sub t1, t2, t1 # -1

    li t2, 3
    mv s3, t2

    beq t0, t1, print_myness_one

    li t2, 3
    mv s3, t2 

    j find_better_one

    after_find_better_instru_3:

    j print_name

    after_printting_name_instru_3:

    after_printting_myness_one_instru_3:  

    j after_instru
instr_4:

    addi t2, t2, 2
    mv s5, t2

    li t3, 4
    mv s3, t3

    j find_index_name

    after_name_instru_4:

    mv t4, s4

    j read_in_matrix

    after_read_matrix_instru_4:

    li t3, 4
    mv s3, t3

    mv s2, s7

    j print_int  # s2

    after_printing_instru_4:

    j after_instru
instr_5:

    addi t2, t2, 2
    mv s5, t2

    li t3, 5
    mv s3, t3

    j find_index_name

    after_name_instru_5:

    mv t4, s4

    j read_in_matrix

    after_read_matrix_instru_5:

    li t3, 5
    mv s3, t3

    mv s2, s6

    j print_int  # s2

    after_printing_instru_5:

    j after_instru
instr_6:    

    addi t2, t2, 2
    mv s5, t2

    li t0, 6
    mv s3, t0

    j find_index_name

    after_name_one_instru_6:

    mv s6, s4

    mv t2, s5
    addi t2, t2, 1
    mv s5, t2

    li t0, 12
    mv s3, t0

    j find_index_name

    after_name_two_instru_6:

    mv s7, s4

    j find_and_read_index

    after_find_and_read_instru_6:

    li t2, 6
    mv s3, t2

    j print_float

    after_printing_instru_6:

    j after_instru


find_index_name:

    la t0, data_name
    mv s2, t0
    mv t1, s5

    li t4, 0
    mv s9, t4 

    for_in_find:

        la t4, name_count
        lw t5, 0(t4)

        mv t4, s9

        beq t4, t5, write_new_name


        lb t2, 0(t0)
        lb t3, 0(t1)

        beq t2, t3,  is_name

        mv t4, s9
        addi t4, t4, 1
        mv s9, t4

        addi t0, t0, 12
        mv s2, t0

        j for_in_find


    is_name:

        addi t0, t0, 1
        addi t1, t1, 1

        li t4, 32
        lb t2, 0(t1)

        beq t4, t2, save_index
        li t4, 0
        beq t4, t2, save_index
        li t4, 10
        beq t4, t2, save_index

        lb t3, 0(t0)

        beq t3, t2, is_name

        j not_name

    not_name:

        mv t1, s5 # back to string name
        
        mv t0, s2 # go to new cell in array 
        addi t0, t0, 12
        mv s2, t1

        mv t4, s9
        addi t4, t4, 1 # add name count
        mv s9, t4


        j for_in_find

    save_index:

        mv s5, t1 # t1 is a ' ' space in input

        la t0, data_name
        mv t2, s2
        sub t2, t2, t0
        li t0, 12
        div t2, t2, t0
        mv s2, t2

        mv s4, s2 # save index
        
        mv t4, s3 # unicode - label

        li t5, 1 # instruction 1 name one = 1 * 1
        beq t4, t5, after_name_one_instru_1

        li t5, 2 # instruction 1 name two = 1 * 2
        beq t4, t5, after_name_two_instru_1

        li t5, 4 # instruction 4
        beq t4, t5, after_name_instru_4

        li t5, 5 # instruction 5
        beq t4, t5, after_name_instru_5

        li t5, 6 # instruction 6 name one = 6 * 1
        beq t4, t5, after_name_one_instru_6

        li t5, 12 # instruction 6 name two = 6 * 2
        beq t4, t5, after_name_two_instru_6

write_new_name:
    mv t1, s5
    mv t0, s2

    for_in_write:
        li t2, 32
        lb t3, 0(t1)

        beq t2, t3, write_zero_for_money

        sb t3, 0(t0)

        addi t1, t1, 1
        addi t0, t0, 1

        j for_in_write

    write_zero_for_money:
    # set 0 $ for new person

        mv s5, t1

        la t0, name_count
        lw t1, 0(t0)
        addi t1, t1, 1
        sw t1, 0(t0)


        mv t0, s2
		la t1, data_name
		sub t0, t0, t1
		li t1, 12
		div t0, t0, t1
		li t1, 4
		mul t0, t0, t1
		la t1, money
		add t0, t0, t1
		
		sw x0, 0(t0)
		
        mv t1, s5

        j save_index

make_money_from_string:

    mv t0, s5
    li t1, 10
    li t2, 0

    for_in_money:
        lb t3, 0(t0)

        li t4, 0
        beq t3, t4, after_make_money

        li t4, 10
        beq t3, t4, after_make_money

        li t4, '.'
        beq t3, t4, point

        li t4, '1'
        beq t3, t4, one

        li t4, '2'
        beq t3, t4, two

        li t4, '3'
        beq t3, t4, three

        li t4, '4'
        beq t3, t4, four

        li t4, '5'
        beq t3, t4, five

        li t4, '6'
        beq t3, t4, six

        li t4, '7'
        beq t3, t4, seven
        
        li t4, '8'
        beq t3, t4, eight

        li t4, '9'
        beq t3, t4, nine

        li t4, '0'
        beq t3, t4, zero


        addi t0, t0, 1
        mv s5, t0

        mv s2, t2

        j for_in_money  

        point:
            addi t0, t0, 1
            mv s5, t0

            j for_in_money


        one : 
            mul t2, t2, t1
            addi t2, t2, 1

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        two : 
            mul t2, t2, t1
            addi t2, t2, 2

            addi t0, t0, 1
            mv s5, t0

            j for_in_money    

        three : 
            mul t2, t2, t1
            addi t2, t2, 3

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        four : 
            mul t2, t2, t1
            addi t2, t2, 4

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        five : 
            mul t2, t2, t1
            addi t2, t2, 5

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        six : 
            mul t2, t2, t1
            addi t2, t2, 6

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        seven : 
            mul t2, t2, t1
            addi t2, t2, 7

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        eight : 
            mul t2, t2, t1
            addi t2, t2, 8

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        nine : 
            mul t2, t2, t1
            addi t2, t2, 9

            addi t0, t0, 1
            mv s5, t0

            j for_in_money

        zero : 
            mul t2, t2, t1
            addi t2, t2, 0

            addi t0, t0, 1
            mv s5, t0

            j for_in_money  
        

write_in_matrix:

    la t4, money

    mv t0, s6
    mv t1, s7

    mv t2, s2

    li t6, 4
    mul t0, t0, t6
    mul t1, t1, t6

    add t0, t0, t4
    add t1, t1, t4

    lw t3, 0(t0)
    sub t3, t3, t2
    sw t3, 0(t0)

    lw t3, 0(t1)
    add t3, t3, t2
    sw t3, 0(t1)


    mv t0, s6
    mv t1, s7

    # this works for finding index in matrix

    la t4, matrix_data

    li t3, 400
    mul t0, t0, t3
    li t3, 4
    mul t1, t1, t3
    add t0, t0, t1
	
	add t0, t0, t4

    lw t3, 0(t0)
	add t3, t3, t2
	sw t3, 0(t0)

    # for mynes
    # writing -1 * t2 (money) in other side of the matrix

    mv t0, s6
    mv t1, s7


    la t4, matrix_data

    li t3, 400
    mul t1, t1, t3
    li t3, 4
    mul t0, t0, t3
    add t1, t1, t0

    add t1, t1, t4

    lw t3, 0(t1)
	sub t3, t3, t2
	sw t3, 0(t1)

    j after_writing_in_matrix

read_in_matrix:
    li t0, 400
    mv t1, s4

    mul t1, t1, t0

    li t2, 0
    mv s6, t2 # led
    mv s7, t2 # borrow
    la t0, name_count
    lw t3, 0(t0)

    li t4, 0

    la t0, matrix_data
    add t1, t1, t0

    for_in_read:
        beq t3, t4, after_for_read

        lw t5, 0(t1)

        bgt t5 , x0, add_s6
        blt t5, x0, add_s7
		
		addi t1, t1, 4
        addi t4, t4, 1
		j for_in_read

    add_s6:
        mv t2, s6
        addi t2, t2, 1
        mv s6, t2

        addi t1, t1, 4
        addi t4, t4, 1

        j for_in_read

    
    add_s7:
        mv t2, s7
        addi t2, t2, 1
        mv s7, t2

        addi t1, t1, 4
        addi t4, t4, 1

        j for_in_read

    after_for_read:
        mv t6, s3

        li t0, 4
        beq t6, t0, after_read_matrix_instru_4
        li t0, 5
        beq t6, t0, after_read_matrix_instru_5



print_float:
    mv t0, s2
    
    li t1, 10
    rem t6, t0, t1
    div t0, t0, t1
    rem t5, t0, t1
    div t0, t0, t1

    mv a0, t0
    li a7, 1       
    ecall

    li t1, 46
	mv a0, t1
    li a7, 11
    ecall

    mv a0, t5
    li a7, 1
    ecall

    mv a0, t6
    li a7, 1
    ecall

    la a0, new_line
    li a7, 4
    ecall

    mv t1, s3

    li t0, 6
    beq t0, t1, after_printing_instru_6


        

print_int:
    mv t0, s2
    mv a0, t0
    
    li a7, 1       
    ecall

    la a0, new_line
    li a7, 4
    ecall

    mv t1, s3

    li t0, 4
    beq t0, t1, after_printing_instru_4

    li t0, 5
    beq t0, t1, after_printing_instru_5


find_and_read_index:
    mv t0, s6 # first name
    mv t1, s7 # second name

    li t2, 400
    mul t1, t1, t2
    li t2, 4
    mul t0, t0, t2

    add t1, t1, t0

    la t2, matrix_data
    add t1, t1, t2

    lw t2, 0(t1)

    mv s2, t2

    j after_find_and_read_instru_6    


find_max:
    mv t0, s5
    la t1, money
    li t2, -1
    mv s4, t2

    li t6, 0

    for_in_find_max:
        lw t2, 0(t1)

        la t5, name_count
        lw t4, 0(t5)

        beq t4, t6, after_find_max_instru_2

        bgt t2, t0, change_max

        addi t1, t1, 4
        addi t6, t6, 1
        j for_in_find_max

    change_max:
        mv t0, t2
        mv s5, t2 # not necessery

        mv t3, t1
        la t4, money
        sub t3, t3, t4
        li t4, 4
        div t3, t3, t4
        mv s4, t3 # index

        addi t1, t1, 4
        addi t6, t6, 1
        j for_in_find_max


find_min:
    mv t0, s5
    la t1, money
    li t2, -1
    mv s4, t2

    li t6, 0

    for_in_find_min:
        lw t2, 0(t1)

        la t5, name_count
        lw t4, 0(t5)

        beq t4, t6, after_find_min_instru_3

        blt t2, t0, change_min

        addi t1, t1, 4
        addi t6, t6, 1
        j for_in_find_min

    change_min:
        mv t0, t2
        mv s5, t2 # not necessery

        mv t3, t1
        la t4, money
        sub t3, t3, t4
        li t4, 4
        div t3, t3, t4
        mv s4, t3 # index

        addi t1, t1, 4
        addi t6, t6, 1
        j for_in_find_min

print_name:
    mv t0, s4
    li t1, 12
    mul t0, t0, t1

    la t1, data_name
    add t0, t0, t1

    for_in_print:

        lb t1, 0(t0)

        li t2, 32
        beq t1, t2, after_printting

        li t2, 0
        beq t1, t2, after_printting

        li t2, 10
        beq t1, t2, after_printting

        mv a0, t1
        li a7, 11
        ecall

        addi t0, t0, 1
        j for_in_print

find_better_one:
    mv t0, s4
    li t1, 4
    mul t0, t1, t0
    la t1, money
    add t0, t0, t1

    lw t1, 0(t0) # money

    mv s8, x0

    la t0, money

    for_in_find_better:
        lw t2, 0(t0)

        beq t1, t2, check_names
		la t0, name_count
        lw t3, 0(t0)

        mv t4, s8

        beq t4, t3, after_find_better



        skip:

        addi t0, t0, 4
        mv t3, s8
        addi t3, t3, 1
        mv s8, t3
        j for_in_find_better

    check_names:

        
        mv t3, t0
        la t4, money
        sub t3, t3, t4
        li t4, 4
        div t3, t3, t4

        mv s9, t3

        beq s9, s4, skip

        li t4, 12
        mul t3, t3, t4
        la t4, data_name
        add t3, t3, t4

        mv t2, s4
        li t4, 12
        mul t2, t2, t4
        la t4, data_name
        add t2, t2, t4


        for_in_check:
            lb t4, 0(t3)
            lb t5, 0(t2)

            li t6, 32
            beq t6, t4, change_index_name

            li t6, 32
            beq t6, t5, after_find_better

            sub t6, t4, t5

            blt t4, t5, change_index_name
            bgt t4, t5, after_find_better

            addi t3, t3, 1
            addi t2, t2, 1

            j for_in_check

change_index_name:

    mv s4, s9
    j after_find_better

after_find_better:
    mv t0, s3

    li t1, 2
    beq t0, t1, after_find_better_instru_2

    li t1, 3
    beq t0, t1, after_find_better_instru_2



print_myness_one:

    li t0, 0
    li t1, 1
    sub t1, t0, t1

    mv a0, t1
    li a7, 1
    ecall

    la a0, new_line
    li a7, 4
    ecall

    j after_printting_myness_one

after_printting:
    mv t3, s3

    la a0, new_line
    li a7, 4
    ecall

    li t0, 2
    beq t3, t0, after_printting_name_instru_2
    li t0, 3
    beq t3, t0, after_printting_name_instru_3   

after_printting_myness_one:
    mv t3, s3

    li t0, 2
    beq t3, t0, after_printting_myness_one_instru_2
    li t0, 3
    beq t3, t0, after_printting_myness_one_instru_3  



end:  

	li a7, 10
  	ecall    
  