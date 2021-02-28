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


beg=int(input('Please input begin of range:'))
end=int(input('Please input end of range:'))
for i in range(beg,end+1):
    print("In case of ",i," ",fizzbuzz(i))
input('Thank you')
