# HWCameraAlbum

カメラ機能と自作アルバムを作成

## 要件
#### 1.タブバーコントローラを使用
#### 2.カメラロールから選択とカメラ撮影の２択で写真を追加可能
#### 3.UserDefaultを使って、追加した写真のURLを保存する
#### 4.アルバムに2カラムで写真を並べる

## POINT

 ※ UserDefaultからデータを取り出し、新しい項目を配列に追加し、また保存するという「データの蓄積ロジック」を認識すること
 
 ※ アルバムページに美しく並べるにはどういう計算が必要なのか、配置する座標を決定するロジックを考慮すること

 ※ ブロック構文を使う部分があるため同期、非同期時のプログラムの動きをブレイクポイントなどで追って実感しておくこと
