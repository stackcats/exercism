# | Register | Usage     | Type    | Description                            |
# | -------- | --------- | ------- | -------------------------------------- |
# | `$a0`    | input     | address | null-terminated string of binary chars |
# | `$v0`    | output    | integer | decimal value of input string          |
# | `$t0-9`  | temporary | any     | used for temporary storage             |

.globl binary_convert

binary_convert:
	move $v0, $zero

loop:
	lb   $t1 0($a0)
	beqz $t1, done
	sll  $v0, $v0, 1
	subi $t1, $t1, '0'
	add  $v0, $v0, $t1
	addi $a0, $a0, 1
	j    loop

done:
	jr $ra
