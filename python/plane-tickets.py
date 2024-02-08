import math

def generate_seat_letters(number):
    lst = ['A', 'B', 'C', 'D']
    for i in range(number):
        yield lst[i % 4]


def generate_seats(number):
    i = 1
    while number >= 0:
        for c in generate_seat_letters(min(4, number)):
            yield f'{i}{c}'
        number -= 4
        i += 1
        if i == 13:
            i += 1
        

def assign_seats(passengers):
    ans = {}
    seats = generate_seats(len(passengers))
    for p in passengers:
        ans[p] = next(seats)
    return ans
    
    

def generate_codes(seat_numbers, flight_id):
    for n in seat_numbers:
        yield f'{n}{flight_id}'.ljust(12, "0")

