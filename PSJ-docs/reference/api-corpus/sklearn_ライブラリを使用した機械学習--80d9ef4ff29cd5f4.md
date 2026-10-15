# sklearn ライブラリを使用した機械学習

sklearn ライブラリを使用した機械学習

🎯 はじめに​

このチュートリアルでは、diabetes データセットの最初の特徴量のみを使用して、シンプルな機械学習モデルを作成し、二次元プロット内のデータポイントを示します。

プロットには直線が描かれており、線形回帰がデータセットの観測された応答と線形近似によって予測された応答との残差平方和を最小限に抑えるように最も適した直線を描こうとする様子が示されています。

また、係数、残差平方和、および決定係数も計算されます。

係数:
 [938.23786125]
平均二乗誤差: 2548.07
決定係数: 0.47

このサンプルは scikit-learn から引用されています。

📖 チュートリアル​

# Encoding for Japanese
# coding: cp932

import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error, r2_score

# 糖尿病データセットをロードする
diabetes_X, diabetes_y = datasets.load_diabetes(return_X_y=True)

# 一つの特徴量のみを使用する
diabetes_X = diabetes_X[:, np.newaxis, 2]

# データをトレーニング/テストセットに分割する
diabetes_X_train = diabetes_X[:-20]
diabetes_X_test = diabetes_X[-20:]

# ターゲットをトレーニング/テストセットに分割する
diabetes_y_train = diabetes_y[:-20]
diabetes_y_test = diabetes_y[-20:]

# 線形回帰オブジェクトを作成する
regr = linear_model.LinearRegression()

# トレーニングセットを使用してモデルをトレーニングする
regr.fit(diabetes_X_train, diabetes_y_train)

# テストセットを使用して予測を行う
diabetes_y_pred = regr.predict(diabetes_X_test)

# 係数を表示する
print('係数: \n', regr.coef_)
# 平均二乗誤差を表示する
print('平均二乗誤差: %.2f'
      % mean_squared_error(diabetes_y_test, diabetes_y_pred))
# 決定係数を表示する: 1 は完璧な予測を意味する
print('決定係数: %.2f'
      % r2_score(diabetes_y_test, diabetes_y_pred))

# 出力をプロットする
plt.scatter(diabetes_X_test, diabetes_y_test,  color='black')
plt.plot(diabetes_X_test, diabetes_y_pred, color='blue', linewidth=3)

plt.xticks(())
plt.yticks(())

plt.show()
