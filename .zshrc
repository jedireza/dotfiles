# ==============================================================================
# Oh My Zsh Configuration
# ==============================================================================

ZSH_DISABLE_COMPFIX="true"
ZSH=$HOME/projects/dotfiles/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE=true
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# Path Configuration
# ==============================================================================

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use

# fzf via Homebrew
if [ -e /opt/homebrew/opt/fzf/shell/completion.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# ==============================================================================
# Exports
# ==============================================================================

export EDITOR="vim"
export VISUAL="vim"

export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export LANG="en_US"
export LC_ALL="en_US.UTF-8"

export LESS_TERMCAP_md="$ORANGE"

# ==============================================================================
# Aliases
# ==============================================================================

alias ls="gls --color=always"
alias lsa='ls -A'
alias subl='"/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"'

# Docker: MongoDB
alias dockerme-mongo-server='docker run --name mongodb -it --rm -v mongodata:/data/db -p 27017:27017 mongo'
alias dockerme-mongo-client="docker run -it --link mongodb:mongo --rm mongo sh -c 'exec mongosh mongodb://mongo:27017'"

# Docker: MySQL
alias dockerme-mysql-server='docker run --name mysqldb -it --rm -v mysqldata:/var/lib/mysql -p 3306:3306 -e MYSQL_ENV_MYSQL_ROOT_PASSWORD=password mysql'
alias dockerme-mysql-client="docker run -it --link mysqldb:mysql --rm mysql sh -c 'exec mysql -hmysql -P3306 -uroot -ppassword'"

# Docker: PostgreSQL
alias dockerme-postgres-server='docker run --name postgresdb -it --rm -v pgdata:/var/lib/postgresql/data -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword postgres:16.9'
alias dockerme-postgres-client="docker run -it --rm --link postgresdb:postgres --rm -e PGPASSWORD=mysecretpassword postgres:16.9 psql -h postgres -U postgres"

# Docker: Redis
alias dockerme-redis-server='docker run --name redisdb -it --rm -v redisdata:/data -p 6379:6379 redis'
alias dockerme-redis-client="docker run -it --link redisdb:redis --rm redis sh -c 'exec redis-cli -h redis'"

# Tmux: new session named as current directory
alias tmuxme='tmux new -s $(echo ${PWD##*/} | sed "s/[_\.]/-/g")'

# ==============================================================================
# Functions
# ==============================================================================

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# ==============================================================================
# Completions
# ==============================================================================

source <(kubectl completion zsh)

# ==============================================================================
# Local Overrides (not committed to git)
# ==============================================================================

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
