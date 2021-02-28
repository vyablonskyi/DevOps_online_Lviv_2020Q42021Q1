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



**1\***

For the fizzbuzz function there has been created [unit test](fizzbuzzutest.py):
```
#!/usr/bin/python3

import unittest
from fizzbuzz import fizzbuzz

class TestFizzbuzz(unittest.TestCase):
    
    def test_f(self):
        z=12
        self.assertEqual(fizzbuzz(z), 'Fizz')

    def test_b(self):
        z=25
        self.assertEqual(fizzbuzz(z), 'Buzz')

    def test_fb(self):
        z=60
        self.assertEqual(fizzbuzz(z), 'FizzBuzz')

if __name__ == '__main__':
    unittest.main()
```
Results of running this script you may see [here](screenshots/002.JPG)



**2**

Develop count_vowels function for counting vowels in input text.Example of usage: count_vowels(annnmemmmtlo) = 3count_vowels(kj  js)=
