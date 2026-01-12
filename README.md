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


# --- zoxide ---
## インストール
sudo apt update
sudo apt install zoxide

.zshrc の末尾に追加
eval "$(zoxide init zsh)"

.bashrc の末尾に追加
eval "$(zoxide init bash)"

source ~/.zshrc
source ~/.bashrc

## command
zoxide は、一度行ったことのあるディレクトリを記憶するためはじめは cd コマンドでいろいろな場所に行く必要がある。

### 高速ジャンプ
z ディレクトリ名

### インタラクティブ選択
zi keyword

### その他の移動
z -: 一つ前にいたディレクトリに戻る
z .. = cd ..
