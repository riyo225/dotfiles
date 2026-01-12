# --- fzf ---
## インストール
https://github.com/junegunn/fzf#using-git
-> using git の項目に行って、git clone 

## command
### ファイル検索
fzf
xargs: 標準入力をコマンドライン引数に入れる
ex) fzf | xargs cat
**: 検索したファイルを持ってくることが出来る
ex) vim ** & tab
ex) cp ** .

### コマンド履歴を検索
ctrl + r & tab

### 標準出力からのあいまい検索
find | fzf
ls | fzf
git branch | fzf

