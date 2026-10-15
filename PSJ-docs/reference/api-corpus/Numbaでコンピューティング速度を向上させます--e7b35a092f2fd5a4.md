# Numbaでコンピューティング速度を向上させます

Numbaでコンピューティング速度を向上させます

🎯 導入​

このチュートリアルでは、Monte Carloメソッドを使用してPIの値を推定する方法を学びます。

Python内蔵機能。

Numba library.

numbaを使用して、計算はできます 40〜100回のスピードアップ.

Numbaは、業界標準を使用して、実行時に最適化されたマシンコードにPython関数を翻訳します LLVM コンパイラライブラリ.
PythonのNumba-compiled数値アルゴリズムは、CまたはFortranの速度に近づくことができます.

Pythonインタープリターを交換したり、別のコンパイルステップを実行したり、C/C ++コンパイラをインストールしたりする必要はありません。
Numbaデコレータの1つをPython機能に適用するだけで、Numbaは残りを行います.

📖 チュートリアル​

Python内蔵機能

Numba図書館

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
print('見積もり {0:.6f} 内で {1:.3f} 秒'.format(value, stop - start))

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
print('見積もり {0:.6f} 内で {1:.3f} 秒'.format(value, stop - start))
