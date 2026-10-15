# Matplotlibを使用したモデル情報のプロット

Matplotlibを使用したモデル情報のプロット

🎯 はじめに​

このチュートリアルでは、matplotlib ライブラリを使用して、モデルの情報（ノード数、要素数、エッジ数、面数など）をプロットする方法を学びます:

パート名、面数、エッジ数、要素数、ノード数をすべてのパートから読み取る。

上記の情報をバー チャートまたは折れ線グラフにプロットして比較する。
このプロットを画像ファイルとしてエクスポートし、PSJを介して MS PowerPointに自動的にインポート することができます。

📖 チュートリアル​

バー チャート

折れ線グラフ

# Encoding for Japanese
# coding: cp932

# Python API ウィンドウのログメッセージをクリアする
JPT.ClearLog()

# サンプルモデルを4つ作成 (すでにモデルが開いている場合は、以下のコードを無視してください)
Geometry.Part.Cube(ilAxialNodes=[90, 70, 50])
Geometry.Part.Cylinder(dlOrigin=[0.03, 0.0, 0.0], dTopOuterRadius=0.005, dBottomOuterRadius=0.005, dHeight=0.03,
    iCircularNodes=100, iAxialNodes=300, iPartColor=6409934)
Geometry.Part.Sphere(dlOrigin=[0.06, 0.0, 0.0], iLatitudeDivisions=100, iLongitudeDivisions=400,
    iPartColor=13259210)
Geometry.Part.Torus(dlOrigin=[0.12, 0.0, 0.0], iCircumNodes=100, iRingNodes=300, iPartColor=7697908)

#############################################################################################
#################################### メインコードを開始 ####################################
#############################################################################################

import numpy as np
import matplotlib.pyplot as plt

def auto_label(rects):
    """
    各バーの上にテキストラベルを添付して、その高さを表示します。
    """
    for rect in rects:
        ax.annotate('{}'.format(rect.get_height()), xy = (rect.get_x() + rect.get_width() / 2, rect.get_height()),
                    xytext = (0, 3), textcoords = "offset points", ha = "center", va = "center", size = 8)

# matplotlibを使用してプロットを開始
labels = []
part_info = []
for part in JPT.GetAllParts():
    labels.append(part.name)
    part_info.append([part.name, len(part.faces), len(part.edges), len(part.elems), len(part.nodes)])
x = np.arange(len(labels))
fig, ax = plt.subplots(figsize = (8, 6))
ax.set_ylabel("合計値")
ax.set_title("モデルに存在するパーツ間の比較")
ax.set_xticks(x)
ax.set_xticklabels(labels, rotation = 'vertical')
ax.autoscale(axis="both")
for i in range(len(part_info)):
    rect_1 = ax.bar(x[i], part_info[i][3], 0.3, color = "magenta", label = part_info[i][0])
    auto_label(rect_1)
    rect_2 = ax.bar(x[i], part_info[i][4], 0.3, color = "gold", label = part_info[i][0])
    auto_label(rect_2)
ax.legend((rect_1, rect_2),
          ("要素数", "ノード数"),
          bbox_to_anchor = (1.05, 1),
          loc = "upper left",
          fancybox = True,
          framealpha = 1,
          shadow = True,
          borderpad = 1)
fig.tight_layout()
plt.show()

# Encoding for Japanese
# coding: cp932

# Python API ウィンドウのログメッセージをクリアする
JPT.ClearLog()

# サンプルモデルを4つ作成 (すでにモデルが開いている場合は、以下のコードを無視してください)
Geometry.Part.Cube(ilAxialNodes=[90, 70, 50])
Geometry.Part.Cylinder(dlOrigin=[0.03, 0.0, 0.0], dTopOuterRadius=0.005, dBottomOuterRadius=0.005, dHeight=0.03,
    iCircularNodes=100, iAxialNodes=300, iPartColor=6409934)
Geometry.Part.Sphere(dlOrigin=[0.06, 0.0, 0.0], iLatitudeDivisions=100, iLongitudeDivisions=400,
    iPartColor=13259210)
Geometry.Part.Torus(dlOrigin=[0.12, 0.0, 0.0], iCircumNodes=100, iRingNodes=300, iPartColor=7697908)

#############################################################################################
#################################### メインコードを開始 ####################################
#############################################################################################

import numpy as np
import matplotlib.pyplot as plt

# matplotlibを使用してプロットを開始
labels = []
part_info = []
for part in JPT.GetAllParts():
    labels.append(part.name)
    part_info.append([part.name, len(part.faces), len(part.edges), len(part.elems), len(part.nodes)])
x = np.arange(len(labels))
fig, ax = plt.subplots(figsize=[10, 8])
ax.set_ylabel("合計値")
ax.set_title("モデルに存在するパーツ間の比較")
ax.set_xticks(x)
ax.set_xticklabels(labels, rotation = 'vertical')
y_elem = []
y_node = []
for i in range(len(part_info)):
    y_elem.append(part_info[i][3])
    y_node.append(part_info[i][4])
line_1 = ax.plot(x, y_elem, marker='o', color = "magenta", label='要素数')
line_2 = ax.plot(x, y_node, marker='x', color = "gold", label='ノード数')
for i in range(len(y_elem)):
    ax.annotate(y_elem[i], (x[i], y_elem[i]), size=8)
    ax.annotate(y_node[i], (x[i], y_node[i]), size=8)
ax.legend(['要素数', 'ノード数'],
          bbox_to_anchor = (1.05, 1),
          loc = "upper left",
          fancybox = True,
          framealpha = 1,
          shadow = True,
          borderaxespad=0.,
          borderpad = 1)
plt.gcf().subplots_adjust(right=0.75)
plt.show()
