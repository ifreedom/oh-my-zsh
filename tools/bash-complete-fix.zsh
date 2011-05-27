# their have function doesn't work in zsh (unset -v)
have() {
  unset have
  (( ${+commands[$1]} )) && have=yes
}

# shopt is bash's setopt
alias shopt=':'

# resolve function name clash (if you don't use autoload -U)
alias _expand=_bash_expand

# these are the options I seem to need to best emulate bash. Some may be
# missing and noshglob is questionable (but solved a specific issue)
emulate -L sh
setopt kshglob noshglob braceexpand

Oliver

#autoload

_bash_complete() {
  local ret=1
  local -a suf matches
  local COMP_POINT COMP_CWORD
  local -a COMP_WORDS COMPREPLY BASH_VERSINFO
  local COMP_LINE="$words"

  (( COMP_POINT = ${#${(j. .)words}} + $$#QIPREFIX + $#IPREFIX + $#PREFIX ))
  (( COMP_CWORD = CURRENT - 1))
  COMP_WORDS=( $words )
  BASH_VERSINFO=( 2 05b 0 1 release )
  
  [[ ${argv[${argv[(I)nospace]:-0}-1]} = -o ]] && suf=( -S '' )
 
  matches=( ${(f)"$(compgen $@)"} )
  
  if [[ -n $matches ]]; then
    if [[ ${argv[${argv[(I)filenames]:-0}-1]} = -o ]]; then
      compset -P '*/' && matches=( ${matches##*/} )
      compset -S '/*' && matches=( ${matches%%/*} )
      compadd -f "${suf[@]}" -a matches && ret=0
    else
      compadd "${suf[@]}" -a matches && ret=0
    fi
  fi

  if (( ret )); then
    if [[ ${argv[${argv[(I)default]:-0}-1]} = -o ]]; then
      _default "${suf[@]}" && ret=0
    elif [[ ${argv[${argv[(I)dirnames]:-0}-1]} = -o ]]; then
      _directories "${suf[@]}" && ret=0
    fi
  fi

  return ret
}

compgen() {
  local opts prefix suffix ret=1 OPTARG OPTIND
  local -a name res results
  local -A shortopts
  
  emulate -L sh
  setopt kshglob noshglob braceexpand nokshautoload

  shortopts=(
    a alias b builtin c command d directory e export f file
    g group j job k keyword u user v variable
  )

  while getopts "o:A:G:C:F:P:S:W:X:abcdefgjkuv" name; do
    case $name in
      [abcdefgjkuv]) OPTARG="${shortopts[$name]}" ;&
      A)
        case $OPTARG in
	  alias) results+=( "${(k)aliases[@]}" ) ;;
	  arrayvar) results+=( "${(k@)parameters[(R)array*]}" ) ;;
	  binding) results+=( "${(k)widgets[@]}" ) ;;
	  builtin) results+=( "${(k)builtins[@]}" "${(k)dis_builtins[@]}" ) ;;
	  command)
	    results+=(
	      "${(k)commands[@]}" "${(k)aliases[@]}" "${(k)builtins[@]}"
	      "${(k)functions[@]}" "${(k)reswords[@]}"
	    )
	  ;;
	  directory)
	    setopt bareglobqual
	    results+=( ${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N-/) )
	    setopt nobareglobqual
	  ;;
	  disabled) results+=( "${(k)dis_builtins[@]}" ) ;;
	  enabled) results+=( "${(k)builtins[@]}" ) ;;
	  export) results+=( "${(k)parameters[(R)*export*]}" ) ;;
	  file)
	    setopt bareglobqual
	    results+=( ${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N) )
	    setopt nobareglobqual
	  ;;
	  function) results+=( "${(k)functions[@]}" ) ;;
	  group)
	    emulate zsh
	    _groups -U -O res
	    emulate sh
	    setopt kshglob noshglob braceexpand
	    results+=( "${res[@]}" )
	  ;;
	  hostname)
	    emulate zsh
	    _hosts -U -O res
	    emulate sh
	    setopt kshglob noshglob braceexpand
	    results+=( "${res[@]}" )
	  ;;
	  keyword) results+=( "${(k)reswords[@]}" ) ;;
	  setopt|shopt) results+=( "${(k)options[@]}" ) ;;
	  signal) results+=( "SIG${^signals[@]}" ) ;;
	  user) results+=( "${(k)userdirs[@]}" ) ;;
      	  variable) results+=( "${(k)parameters[@]}" ) ;;
	  helptopic|job|running|stopped) ;;
	esac
      ;;
      F)
        COMPREPLY=()
	$OPTARG "${words[0]}" "${words[CURRENT-1]}" "${words[CURRENT-2]}"
	results+=( "${COMPREPLY[@]}" )
      ;;
      G)
        setopt nullglob
        results+=( ${~OPTARG} )
	unsetopt nullglob
      ;;
      W) eval "results+=( $OPTARG )" ;;
      C) results+=( $(eval $OPTARG) ) ;;
      P) prefix="$OPTARG" ;;
      S) suffix="$OPTARG" ;;
      X)
        if [[ ${OPTARG[0]} = '!' ]]; then
	  results=( "${(M)results[@]:#${OPTARG#?}}" )
	else
 	  results=( "${results[@]:#$OPTARG}" )
	fi
      ;;
    esac
  done
  
  # support for the last, `word' option to compgen. Not particularly valuable
  # and without it zsh matching can do a better job. Comment in if needed.
  #shift $(( OPTIND - 1 ))
  #(( $# )) && results=( "${(M)results[@]:#$1*}" )

  print -l -- "$prefix${^results[@]}$suffix"
}

complete() {
  emulate -L zsh
  local args void cmd print remove
  args=( "$@" )
  zparseopts -D -a void o: A: G: W: C: F: P: S: X: a b c d e f g j k u v \
      p=print r=remove
  if [[ -n $print ]]; then
    for cmd print in ${(kv)_comps[(R)_bash*]}; do
      print "complete ${print#* } $cmd"
    done
  elif [[ -n $remove ]]; then
    print "not implemented: -r option"
  else
    compdef _bash_complete\ ${(j. .)${(q)args[1,-1-$#]}} "$@"
  fi
}

unfunction bashcompinit
autoload -U bashcompinit
return 0
