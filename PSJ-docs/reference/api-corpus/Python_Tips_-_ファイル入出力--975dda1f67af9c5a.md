# Python Tips - ファイル入出力

Python Tips - ファイル入出力

🎯 Introduction​

本ドキュメントでは、Pythonで外部ファイルを読み込み、その内部の文字列を利用する際の基本的な手法について、実例を挙げながら紹介します。

基本操作

文字化けの対応（文字コード）

文字列処理

CSVファイル処理

ファイルパス表現とファイルパス区切り文字

ファイル・フォルダ取得Tips（osモジュール）

📖 ファイル操作の基礎​

既存のファイルを読み込む​

あらかじめC:\Temp下に、下記の内容のSample.txtを用意しておきます。

#Number,Type,ID,Value
1,Node,5,300
2,Node,6,800
3,Element,8,4.65

Pythonのopen関数を利用します。
open関数の典型的な利用方法には、下記のようなものがあります。

ファイルの中身を指す変数を用意し、readline関数で一行ずつ読んで表示します。

Filepath='C:/Temp/Sample.txt'
with open(Filepath,'r') as fr:
    print(fr.readline())
    print(fr.readline())
    print(fr.readline())
    print(fr.readline())

ファイルの中身をfor文で最後まで一行ずつ読んで表示します。

Filepath='C:/Temp/Sample.txt'
for line in open(Filepath,'r'):
    print(line)

ファイルの中身を指す変数を用意し、readline関数で一行ずつ読んで表示します。

Filepath='C:/Temp/Sample.txt'
with open(Filepath,'r') as fr:
    while line := fr.readline():
        print(line)

ファイルの中身を指す変数を用意し、resdlinesで複数行一度に読み、リストに格納したものを表示します。

Filepath='C:/Temp/Sample.txt'
with open(Filepath,'r') as fr:
    print(fr.readlines())

ファイルの中身を指す変数を用意する別の方法です。この場合、読み終えたらcloseで明示的にファイルを閉じる必要があります。

Filepath='C:/Temp/Sample.txt'
fr = open(Filepath,'r')
print(fr.readlines())
fr.close()

新規ファイルに書き出す​

C:\Temp下にMyNewFile.txtを作成し、文字列を出力します。

Filepath='C:/Temp/MyNewFile.txt'
with open(Filepath,'w') as fw:
    fw.write('出力文字列:1行目\n')
    fw.write('出力文字列:2行目\n')

既存のファイルに追記する​

C:/Temp下の既存のファイルMyNewFile.txtに、文字列を追記します。

Filepath='C:/Temp/MyNewFile.txt'
with open(Filepath,'a') as fw:
    fw.write('出力文字列:3行目\n')
    fw.write('出力文字列:4行目\n')

📖 文字コードと文字化け​

ファイルを読み込んで表示した場合に文字化けする場合、あるいはUnicodeDecodeErrorというエラーが表示される場合、ファイルがどの文字コードで保存されているかを確認し、ファイルオープン時にencodingでエンコードを適切に指定する必要があります。

例えば、UTF-8形式で保存されたファイルを読み込み用にオープンする場合には、下記のようにencodingを追加し、文字コードを指定します。

import os
Folder = 'C:/Temp'
#文字コードUTF-8のファイルを開く
File = 'UTF-8.txt'
path = os.path.join(Folder, File)
for line in open(path,'r',encoding='utf8'):
    print(line)

なお、Pythonでコーディングする場合、OSの文字コードが使用されます。 日本語OSであればShift-JISとなりますので、ファイルを書き出す場合、encodingを指定しなければそのファイルはShift-JIS形式となります。

📖 文字列処理​

ファイルの文字列を読み込んだ場合、改行や文字列前後の空白などまでそのまま読み込まれます。
Pythonには便利な文字列処理の関数や手法が数多くあります。
そのいくつかを紹介します。

import os
for line in open('C:/Temp/Sample.txt','r'):

    #文字列の中に"Element"があれば、読み込みをスキップする
    if 'Element' in line:
        continue

    #文字列前後の連続した空白文字（全角/半角スペース、タブ、改行）を削除
    line_correct=line.strip()

    #指定の文字を置き換える（空白文字に置き変えれば削除となる）
    plane_line=line_correct.replace('#','')

    #文字列をカンマを区切り文字として分割し、リストに入力
    data=plane_line.split(',')
    print(data)

また、文字列はスライスを使って加工することもできます。

target_string='Number of faces=5'

print(target_string)
# Number of faces=5

print(target_string[10:15])
# faces

print(target_string[:-1])
# Number of faces=

print(target_string[-1:])
# 5

📖 CSVファイル処理​

Pythonには、CSVファイル（カンマ区切りテキストファイル）を容易に取り扱うcsvモジュールが用意されています。
Jupiterからの出力テキストファイルはUTF-8形式のCSVファイルがほとんどですので、csvモジュールを使用することでより簡単にデータを扱うことができます。

CSVファイル出力の例
C:/Temp下に、下記の内容のdata.csvがあるとします。

ID,エンティティタイプ,パーツ名,X位置,Y位置,Z位置
489,Node,Top ,2.908571,5.355256,5.354674
490,Node,Bottom,4.258526,6.032439,3.939537
491,Node,Top,3.431358,6.67299,5.133599
492,Node,Left,4.69846,5.852374,5.210019
493,Node,Left,4.522084,7.169787,4.026808
496,Node,Right,6.017674,5.75383,5.21671

csvモジュールを使った処理の例を示します。

import csv                       #csvモジュール使用宣言
filename = "C:/Temp/data.csv"

with open(filename, encoding='utf-8', newline='') as f:
  reader = csv.reader(f)          #CSVファイルの内容を読み込む     

  row1_list = []
  row3_list = []
  row6_list = []

  for row in reader:
    if reader.line_num == 1:       #line_num ==1はヘッダーなので読み飛ばす
        continue                   

    row1_list.append(row[0])       #1列目のデータを取得
    row3_list.append(row[2])       #3列目のデータを取得
    row6_list.append(row[5])       #6列目のデータを取得

print(row1_list)
# ['489', '490', '491', '492', '493', '496']

print(row3_list)
# ['Top ', 'Bottom', 'Top', 'Left', 'Left', 'Right']

print(row6_list)
# ['5.354674', '3.939537', '5.133599', '5.210019', '4.026808', '5.21671']

#リスト内要素はいずれもstr型となっているので、必要に応じてタイプを変換する
for i in row6_list:
    print(float(i))

また、下記のように内包表記を使用すると、csvファイルの各行を一次元配列（リスト）、各要素を二次元配列として扱うことができます。

import csv              #csvモジュール使用宣言
filename = "C:/Temp/data.csv"

with open(filename, encoding='utf-8', newline='') as f:
    reader = csv.reader(f)
    list = [row for row in reader]

print(list[1])          #csvファイルの2行目
#['489', 'Node', 'Top ', '2.908571', '5.355256', '5.354674']

print(list[2][2])       #csvファイルの3行3列目
#Bottom

📖 ファイルパス区切り表現​

Pythonコードでファイルパスを表現する場合、パス区切り文字は「/」(スラッシュ)となります。
Windowsv OSではパス区切りを表現する際に「\」（バックスラッシュもしくは￥マーク）を使いますが、Pythonコード内ではこの記号は特殊文字とみなされますので、下記のいずれかの表記に変更する必要があります。

#Pythonのファイルパス区切り
Filepath='C:/Temp/MyFile.txt'

#特殊文字のバックスラッシュを2回書くことでバックスラッシュをファイルパス区切りとする。
Filepath='C:\\Temp\\MyFile.txt'

#raw(ロー)文字列を利用して、Windowsのファイルパス区切りを使用。
Filepath=r'C:\Temp\MyFile.txt'
#この表記方法の場合、パス末尾にはバックスラッシュは使用できません（行末の'を特殊文字と認識できなくなるため）。
#(NG例)
#Folderpath=r'C:\Temp\'

📖 ファイルパスの連結​

ファイルパスは文字列ですので、ファイルパスを連結する際には文字列の和を使うこともできますが、
ファイルパスを安全に連結するには、osモジュールをインポートして、os.path.join()関数を利用することが推奨されています。例えば下記のような場合にも適切な位置に各OSの使うパス区切りを追加し、エラー無く使用できます。

import os
Folder = 'C:/Temp'
File = 'Sample.txt'
path = os.path.join(Folder, File)
print(path)

📖 osモジュール​

osモジュールは、os依存の機能を利用するためのpythonモジュールで、特にファイル・フォルダ操作に便利な関数を多数持っています。
よく使う例を紹介します。

#osモジュールの使用宣言
import os

#パス（ファイル/フォルダ)の存在確認
isExists=os.path.exists(r'C:\Temp\MyFile.txt')
print(isExists)

#指定パスがファイルかどうかを判定→ファイル存在確認に利用
isFile=os.path.isfile(r'C:\Temp\Sample.txt')
print(isFile)

#指定パスがフォルダかどうかを判定→フォルダ存在確認に利用
isDir=os.path.isdir(r'C:\Temp')
print(isDir)

#指定フォルダ内のファイルをリストに格納
fileList=os.listdir('C:\Temp')
for file in fileList:
    print(file)

#指定フォルダ下のフォルダ・ファイルツリーを取得
for currFolder,folders,files in os.walk('C:\Temp'):
    print(currFolder)
    print(folders)
    print(files)
