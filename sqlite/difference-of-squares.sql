update 'difference-of-squares'
set result =
    case
    when property = 'squareOfSum' then pow((1 + number) * number / 2, 2)
    when property = 'sumOfSquares' then number * (number + 1) * (number * 2 + 1) / 6
    else pow((1 + number) * number / 2, 2) - number * (number + 1) * (number * 2 + 1) / 6
    end
