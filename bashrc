# ALEX'S BASH CONFIG FILE

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Check that we haven't already been sourced
[[ -z "$MY_BASH_RC" ]] && MY_BASH_RC=1 || return

# Controlling bash history file
HISTCONTROL=ignorespace:ignoredups:erasedups  # don't put on history lines starting with space or duplicate lines
shopt -s histappend                           # each session append to the history, instead of overriding it
HISTSIZE=1000                                 # each session adds at max this amout of entries to the history
HISTFILESIZE=5000                             # the history file has at max this amout of entries

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly
export LESS='--ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --tabs=4 --window=-2'  # case insensitive search, show "status line", tabs as 4 spaces, keep 2 lines of "context" with page down
LESSPIPE='/usr/local/bin/lesspipe.sh'                      # adjust path, download here: https://github.com/wofr06/lesspipe 
[[ -x "$LESSPIPE" ]] && eval "$(SHELL=/bin/sh $LESSPIPE)"  # syntax highlight and show binary files

# Make better completions
shopt -s nocaseglob   # ignore case when expanding glob
shopt -s nocasematch  # ignore case when matching strings
shopt -s globstar     # enable "recursive" glob, ex: ls **/*.txt

# Import other files
test -f ~/.bash_functions   && source ~/.bash_functions    # helper functions
test -f ~/.bash_aliases     && source ~/.bash_aliases      # useful aliases
test -f ~/.bash_completions && source ~/.bash_completions  # command completions
test -f ~/.bash_local       && source ~/.bash_local        # put your own stuff here, so you can update this file safely

# Show a very informative prompt command
PS1='\[\e]0;\W\a\] \[\e[32m\]\n\u@\h \[\e[35m\]$MSYSTEM \[\e[33m\]\w \[\e[36m\]`__git_branch_current` \[\e[34m\]\A \[\e[90m\]\n\$ \[\e[0m\]'
