# マウスカーソル変更

マウスカーソルをさっと変更できるようにCLIで出来るようにしたやつ

## 使い方(初期設定)
1. 使いたいカーソル群を`%SystemRoot%\Cursors\`にディレクトリを作成して設置する。

     例: `%SystemRoot%\Cursors\アグネスタキオン\*.cur`
3. カーソル名(`.cur`,`.ani`)の名称を以下の名称にする。
     ||||
     |:--|:--|:--|
     |01_通常.cur|07_手書き.cur|13_移動.cur|
     |02_ヘルプの選択.cur|08_利用不可.cur|14_代替選択.cur|
     |03_バックグラウンド作業中.cur|09_上下に拡大・縮小.cur|15_リンク選択.cur|
     |04_待ち状態.cur|10_左右に拡大・縮小.cur|16_場所の選択.cur|
     |05_領域選択.cur|11_斜めに拡大・縮小1.cur|17_人の選択.cur|
     |06_テキスト選択.cur|12_斜めに拡大・縮小2.cur||

     ※`.ani`の場合は`.cur`の部分を置き換える
4. `コントロールパネル\すべてのコントロール パネル項目\マウス`の`ポインター`のタブで上記のカーソル群を名前を付けて保存する。
5. `changeCoursor.bat`の設定を書き換える。
    * `dirName=`に上記`1.`で作成したディレクトリ名を記入
      <br>例: `dirName=アグネスタキオン`
    * `themeName=`に上記`4.`で保存したデザイン名を記入
      <br>例: `themeName=タキオンカーソル`
6. 完成

## 使い方(実行)
1. `changeCoursor.bat`をダブルクリックで実行
2. 選択
3. 完了