# Kun Wang <ifreedom.cn@gmail.com>
# Written since summer 2010

# Check for an interactive session
[ -z "$PS1" ] && return

#设定相关路径{{{
if [ -d "/usr/local/bin" ] ; then
  PATH=/usr/local/bin:${PATH}
fi

# Set PATH so it includes user's private bin if it exists
 if [ -d "${HOME}/bin" ] ; then
   PATH=${HOME}/bin:${PATH}
 fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH=${HOME}/man:${MANPATH}
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH=${HOME}/info:${INFOPATH}
# fi
#}}}

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

eval `dircolors $ZSH/ls_colors`

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="tjkirch"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

DISABLE_AUTO_UPDATE=true # disable update
source $ZSH/oh-my-zsh.sh

# Load all of the config files in custom/lib that end in .zsh
for config_file ($ZSH/custom/lib/*.zsh) source $config_file

# Customize to your needs...

zstyle ':completion:*:sudo:*' command-path /usr/sbin /sbin /usr/bin /bin

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char
bindkey "\e[2~" overwrite-mode # Insert
bindkey "\e[4~" end-of-line # End
bindkey "\e[1~" beginning-of-line # Home

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

export PATH=$PATH:/opt/pspsdk/bin:/opt/luadist/bin
export BROWSER='chromium' #if have not browser, you can set it fow colourful man --html
export EDITOR='emacsclient'
export ALTERNATE_EDITOR='emacs& && emacsclient'

LUA_PATH="/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua"

LUA_CPATH="/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so"

export LUA_PATH LUA_CPATH

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# 让终端也支持 NotifyOSD，接收任务完成通知
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"' 
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[$?] $(alert_helper)"'

[[ -x ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm
