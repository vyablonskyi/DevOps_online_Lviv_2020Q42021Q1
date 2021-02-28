**1**

The "fizzbuzz" functon has been written and saved in [fizzbuzz.py](fizzbuzz.py) file:
```
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
```
this function has been used as imoprted in the test [script1.py](script1.py)

Results of running this script you may see [here](screenshots/001.JPG)


1* Make unit tests for your new FizzBuzz function.

2. Develop count_vowels function for counting vowels in input text.Example of usage: count_vowels(annnmemmmtlo) = 3count_vowels(kj  js)=
