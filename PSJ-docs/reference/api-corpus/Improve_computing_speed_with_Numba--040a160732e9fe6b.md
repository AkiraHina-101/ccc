# Improve computing speed with Numba

Improve computing speed with Numba

🎯 Introduction​

In this tutorial, you'll learn how to estimate the value of Pi using Monte Carlo method, by:

Python built-in function.

Numba library.

Using Numba, the calculation can speed up from 40 to 100 times.

Numba translates Python functions to optimized machine code at runtime using the industry-standard LLVM compiler library.
Numba-compiled numerical algorithms in Python can approach the speeds of C or FORTRAN.

You don't need to replace the Python interpreter, run a separate compilation step, or even have a C/C++ compiler installed.
Just apply one of the Numba decorators to your Python function, and Numba does the rest.

📖 Tutorial​

Python built-in function

Numba library

import random
import timeit

def monte_carlo_pi(nsamples):
    acc = 0
    for i in range(nsamples):
        x = random.random()
        y = random.random()
        if (x ** 2 + y ** 2) < 1.0:
            acc += 1
    return 4.0 * acc / nsamples

start = timeit.default_timer()
value = monte_carlo_pi(100_000_000)
stop = timeit.default_timer()
print('Estimate {0:.6f} within {1:.3f} seconds'.format(value, stop - start))

import random
import timeit
from numba import jit

@jit(nopython=True)
def monte_carlo_pi(nsamples):
    acc = 0
    for i in range(nsamples):
        x = random.random()
        y = random.random()
        if (x ** 2 + y ** 2) < 1.0:
            acc += 1
    return 4.0 * acc / nsamples

start = timeit.default_timer()
value = monte_carlo_pi(100_000_000)
stop = timeit.default_timer()
print('Estimate {0:.6f} within {1:.3f} seconds'.format(value, stop - start))
