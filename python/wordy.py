import re

def answer(question):
    arr = re.split(r'(-?\d+|plus|minus|multiplied by|divided by)', question)
    
    st = []
    ops = []
    is_op = False
    
    for each in arr:
        if each in ['What is ', '?', ' ', 'What is?']:
            continue
        
        if re.search(r'-?\d+', each):
            if is_op:
                raise ValueError('syntax error')
            st.append(int(each))
            is_op = not is_op
        elif each in ['plus', 'minus', 'multiplied by', 'divided by']:
            if not is_op:
                raise ValueError('syntax error')
            ops.append(each)
            is_op = not is_op
        else:
            raise ValueError('unknown operation')

    if st == []:
        raise ValueError('syntax error')
        
    st = st[::-1]
    for op in ops:
        if len(st) < 2:
            raise ValueError('syntax error')
        
        a = st.pop()
        b = st.pop()
        
        if op == 'plus':
            st.append(a + b)
        elif op == 'minus':
            st.append(a - b)
        elif op == 'multiplied by':
            st.append(a * b)
        else:
            st.append(a // b)
            
    if len(st) != 1:
        raise ValueError('syntax error')
    
    return st[0]
