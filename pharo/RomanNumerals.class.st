Class {
	#name : #RomanNumerals,
	#superclass : #Object,
	#category : #'Exercise@RomanNumerals'
}

{ #category : #example }
RomanNumerals >> romanNumber: anInteger [
    | roman n |
    anInteger <= 0 ifTrue: [ self error: 'Number must be greater than 0' ].
    roman := ''.
    n := anInteger.
    {1000 -> 'M'. 
    900 -> 'CM'. 
    500 -> 'D'. 
    400 -> 'CD'. 
    100 -> 'C'. 
    90 -> 'XC'. 
    50 -> 'L'. 
    40 -> 'XL'. 
    10 -> 'X'. 
    9 -> 'IX'. 
    5 -> 'V'. 
    4 -> 'IV'. 
    1 -> 'I'}  
    asOrderedDictionary
    associationsDo: [: pair |
        [ pair key <= n ] whileTrue: [roman := roman, pair value. n := n - pair key.]
    ].
    ^ roman.
]
