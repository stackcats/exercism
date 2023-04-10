"""
This exercise stub and the test suite contain several enumerated constants.

Since Python 2 does not have the enum module, the idiomatic way to write
enumerated constants has traditionally been a NAME assigned to an arbitrary,
but unique value. An integer is traditionally used because it’s memory
efficient.
It is a common practice to export both constants and functions that work with
those constants (ex. the constants in the os, subprocess and re modules).

You can learn more here: https://en.wikipedia.org/wiki/Enumerated_type
"""

# Possible sublist categories.
# Change the values as you see fit.
SUBLIST = 1
SUPERLIST = 2
EQUAL = 3
UNEQUAL = 4

def aux(lst1, lst2):
    len1 = len(lst1)
    len2 = len(lst2)
        
    for i in range(len2-len1+1):
        if lst1 == lst2[i:i+len1]:
            return True
        
    return False
        
def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL
    
    if aux(list_one, list_two):
        return SUBLIST
    if aux(list_two, list_one):
        return SUPERLIST
        
    return UNEQUAL
