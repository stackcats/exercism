## Registers

# | Register | Usage     | Type    | Description                                      |
# | -------- | --------- | ------- | ------------------------------------------------ |
# | `$a0`    | input     | integer | year to check                                    |
# | `$v0`    | output    | boolean | input is leap year (`0` = `false`, `1` = `true`) |
# | `$t0-9`  | temporary | any     | used for temporary storage                       |

.globl is_leap_year

is_leap_year:
	li   $t0, 400
	div  $a0, $t0
	mfhi $t0
	beqz $t0, is_leap

	li   $t0, 100
	div  $a0, $t0
	mfhi $t0
	beqz $t0, is_not_leap

	li   $t0, 4
	div  $a0, $t0
	mfhi $t0
	beqz $t0, is_leap

is_not_leap:
	li $v0, 0
	jr $ra

is_leap:
	li $v0, 1
	jr $ra
