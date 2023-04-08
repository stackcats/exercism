import re


def response(hey_bob):
    hey_bob = hey_bob.strip()
    if  hey_bob == '':
        return 'Fine. Be that way!'
        
    is_question = hey_bob[-1] == '?'
    is_yell = re.search(r'[A-Z]', hey_bob) and not re.search(r'[a-z]', hey_bob)

    if is_question and is_yell:
        return 'Calm down, I know what I\'m doing!'

    if is_question:
        return 'Sure.'

    if is_yell:
        return 'Whoa, chill out!'
    
    return 'Whatever.'
