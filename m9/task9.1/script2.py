#!/usr/bin/python3

def count_vowels (t):
    vowels = ('a','A','e','E','i','I','o','O','u','U')
    i=0
    for el in t:
        if el in vowels:
            i+=1
    return i


tx=input('Please input some text to count vovels:')
print(count_vowels(tx)," vovels in your text")
input('')
