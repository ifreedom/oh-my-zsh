#为历史纪录中的命令添加时间戳
# setopt EXTENDED_HISTORY
#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

# #每个目录使用独立的历史纪录{{{
# cd() {
# 	builtin cd "$@"                             # do actual cd
# 	fc -W                                       # write current history  file
# 	local HISTDIR="$HOME/.zsh/history$PWD"      # use nested folders for history
# 		if  [ ! -d "$HISTDIR" ] ; then          # create folder if needed
# 			mkdir -p "$HISTDIR"
# 		fi
# 		export HISTFILE="$HISTDIR/zhistory"     # set new history file
# 	touch $HISTFILE
# 	local ohistsize=$HISTSIZE
# 		HISTSIZE=0                              # Discard previous dir's history
# 		HISTSIZE=$ohistsize                     # Prepare for new dir's history
# 	fc -R                                       #read from current histfile
# }
# mkdir -p $HOME/.zsh/history$PWD
# export HISTFILE="$HOME/.zsh/history$PWD/zhistory"
# function allhistory {
# 	find $HOME/.zsh/history -name zhistory|
# 	while read f; do
# 		cat "$f"
# 	done
# }
# function convhistory {
# 	sort $1 | uniq |
# 	sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |
# 	awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'
# }
# #使用 histall 命令查看全部历史纪录
# function histall { convhistory =(allhistory) |
# 			sed '/^.\{20\} *cd/i\\' }
# #使用 hist 查看当前目录历史纪录
# function hist { convhistory $HISTFILE }
# #全部历史纪录 top44
# function top44 { allhistory | awk -F':[ 0-9]*:[0-9]*;' '{ $1="" ; print }' | sed 's/ /\n/g' | sed '/^$/d' | sort | uniq -c | sort -nr | head -n 44 }
# #历史命令 top10
# alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
