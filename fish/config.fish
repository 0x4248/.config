alias python python3
alias pip pip3
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'
alias grep 'grep --color=auto'
alias c clear
alias cls clear
alias n nvim
alias e exit
alias q exit
alias quit exit

function fish_greeting
    set CYAN (set_color -o cyan)
    set NC (set_color normal)
    echo "Welcome to $(uname -s) $(uname -r)"
    echo ""
    echo "    * Hostname: $CYAN$(uname -n)$NC"
    echo "    * Uptime: $CYAN$(uptime)$NC"
    echo "    * Logged in as: $CYAN$(whoami)$NC"
    echo "    * Shell: $CYAN$SHELL$NC"
    echo ""
    echo ---------------------------------
    echo "Login time:"
    echo "$CYAN$(date)$NC"
    echo ---------------------------------
end

function owoii
    owo $argv | figlet
end

set -x PATH $PATH ~/.scripts

if status is-interactive

end
