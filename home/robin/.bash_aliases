# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases to ls
alias ll='ls -lF'
alias la='ls -AF'
alias l='ls -CF'


# Alias nvim to vim if it is installed
if ! command -v nvim &> /dev/null; then
  alias vim="nvim"
fi
