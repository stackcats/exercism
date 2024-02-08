def egg_count(display_value):
    eggs = 0
    while display_value > 0:
        if display_value & 1 == 1:
            eggs += 1
        display_value >>= 1
    return eggs
