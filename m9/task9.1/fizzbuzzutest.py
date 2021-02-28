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

    
