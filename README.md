# 概要
Ruby学習の自主課題として、テトリスを作りました。  
リポジトリのRootディレクトリから、以下のコマンドで実行します。  
```ruby Tetris.rb```  

画面の描画にcursesを使用しています。  
以下のコマンドでインストールできます。(インストールできない場合、実行環境にCコンパイラ等が不足している場合があります。)  
```gem install curses```  

Windows11のターミナルで、WSLを使ってUbuntu上で動作確認しています。  
環境によっては実行時のレイアウトが崩れる場合があります。  

# 操作方法
Aキー: 操作ミノを左に移動  
Dキー: 操作ミノを右に移動  
Jキー: 操作ミノを左に回転  
Kキー: 操作ミノを右に回転  
Sキー: 操作ミノの落下を加速  