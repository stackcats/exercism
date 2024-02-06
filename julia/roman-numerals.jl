const romans = [
    (1000, "M"),
    (900 , "CM"),
    (500 , "D"),
    (400 , "CD"),
    (100 , "C"),
    (90 , "XC"),
    (50 , "L"),
    (40 , "XL"),
    (10 , "X"),
    (9 , "IX"),
    (5 , "V"),
    (4 , "IV"),
    (1 , "I")
]

function to_roman(number)
    if number <= 0
        error()
    end

    s = ""
    for (k, v) in romans
        while number >= k
            s *= v
            number -= k
        end
    end
    s
end

