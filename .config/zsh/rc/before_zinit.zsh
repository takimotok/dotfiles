# history
# -----

# 履歴ファイル 保存先
hISTFILE=~/.zsh_history
# メモリに保存される履歴件数
HISTSIZE=1000000
# 履歴ファイルに保存される履歴件数
SAVEHIST=1000000
# 開始と終了を記録
setopt EXTENDED_HISTORY
# 異なる terminal で開いた zsh 間で history 共有
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 履歴をインクリメンタルに追加
setopt inc_append_history


# others
# -----

# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# Ctrl+S/Ctrl+Q によるフロー制御 無効化
setopt NO_FLOW_CONTROL
setopt no_flow_control
# Ctrl+Dでzshを終了しない
setopt ignore_eof
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups


# key bind
# -----
# as emacs
bindkey -e
# ^r (or ^s)で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^S" history-incremental-search-forward

