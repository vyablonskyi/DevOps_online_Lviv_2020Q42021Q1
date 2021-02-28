#!/usr/bin/python3

from fizzbuzz import fizzbuzz


beg=int(input('Please input begin of range:'))
end=int(input('Please input end of range:'))
for i in range(beg,end+1):
    print("In case of ",i," ",fizzbuzz(i))
input('Thank you')
