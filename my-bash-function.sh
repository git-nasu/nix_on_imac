setopt AUTO_CD

function chpwd() {
    if [[ $(pwd) != "$HOME" ]];then
        ls
    fi
}

autoload chpwd


function mk() {
	mkdir -p "$1" && cd "$1" && pwd
}

autoload  mk
