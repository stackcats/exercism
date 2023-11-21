# | Register | Usage     | Type    | Purpose                    |
# | -------- | --------- | ------- | -------------------------- |
# | `$a0`    | input     | integer | given value                |
# | `$v0`    | output    | integer | difference of squares      |
# | `$t0-9`  | temporary | any     | used for temporary storage |

.globl difference_of_squares

# [n(n + 1)] / 2
square_of_sum:
	addi $v0, $a0, 1
	mulu $v0, $v0, $a0
	srl  $v0, $v0, 1
	mulu $v0, $v0, $v0
	jr   $ra

# [n(n + 1)(2n + 1)] / 6
sum_of_square:
	move $t1, $a0
	addi $t2, $a0, 1
	mulu $t3, $a0, 2
	addi $t3, $t3, 1
	mulu $t1, $t1, $t2
	mulu $t1, $t1, $t3
	li   $t4, 6
	div  $t1, $t4
	mflo $v1
	jr   $ra

difference_of_squares:
	move $t0, $ra
	jal  sum_of_square
	jal  square_of_sum
	subu $v0, $v0, $v1
	jr   $t0
