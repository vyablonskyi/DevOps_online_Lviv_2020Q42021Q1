#!/usr/bin/python3

def fizzbuzz(x):
    if x%3==0:
        if x%5==0:
            return 'FizzBuzz'
        else:
            return 'Fizz'
    elif x%5==0:
        return 'Buzz'
    else:
        return ''
