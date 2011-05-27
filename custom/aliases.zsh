#命令别名 {{{
alias -g G='git'
alias -g S='tmux -L'

alias df='df -h'
alias du='du -h'

#alias -g cp='cp -i'
#alias -g mv='mv -i'
#alias -g rm='rm -i'

alias -g E='emacsclient'
alias -g EE='emacs'

alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort

# do a du -hs on each dir on current path
alias lsdir="for dir in *;do if [ -d \$dir ];then du -hsL \$dir;fi;done"
#}}}

#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
# hash -d WWW="/home/lighttpd/html"
# hash -d ARCH="/mnt/arch"
hash -d P="/var/cache/pacman/pkg"
hash -d A="/var/abs"
hash -d L="/home/ifreedom/local"
hash -d M="/home/packages"
hash -d D="/home/ifreedom/Downloads"
hash -d E="/etc/env.d"
hash -d C="/etc/conf.d"
hash -d I="/etc/rc.d"
hash -d X="/etc/X11"
#hash -d BK="/home/r00t/config_bak"
#}}}
