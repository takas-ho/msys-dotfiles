#!/bin/bash

cat ./.manageignore  | sed -e s/^M// > ./.manageignore-lf
FILES=(`ls | grep -v --file=./.manageignore-lf`)
rm ./.manageignore-lf

function custom_path () {
    for i in "${!PATHS[@]}"
    do
        if [[ $1 == "$i" ]]; then
            return 0
        fi
    done

    return 1
}

function new_path () {
    echo "$HOME/.$1"
}

function ln() {
	if test -d "$2"
	then
		is_dir="/d"
	else
		is_dir=
	fi

	local cmd_src_dir=`dirname "$2"`
	local cmd_src_file=`basename "$2"`
	local cmd_src=$(cd "$cmd_src_dir"; cmd.exe /c cd)\\$cmd_src_file

	local cmd_dest_dir=`dirname "$3"`
	local cmd_dest_file=`basename "$3"`
	local cmd_dest=$(cd "$cmd_dest_dir"; cmd.exe /c cd)\\$cmd_dest_file

	cmd.exe /c "mklink $is_dir \"$cmd_dest\" \"$cmd_src\""
}

# Links the passed filename to its new location
function link () {
    local filename=$1

    if [[ ! -e $filename ]]; then
        echo "$filename doesn't exist"
        return
    fi

    local path=$(new_path "$filename")
    if [[ ! -e "$path" ]]; then
        echo "Linking $filename to $path"
        ln -s "$PWD/$filename" "$path"
    fi
}

# Delete the linked file path
function unlink () {
    local filename=$1
    local path=$(new_path "$filename")

    if [ -e "$path" ]; then
        rm "$(new_path "$1")"
        echo "Removing $(new_path "$1")"
    fi
}

# Loops through and link all files without links
function install_links () {
    for FILE in "${FILES[@]}"
    do
        link $FILE
    done
}

# Function to remove all linked files
function remove_links () {
    for FILE in "${FILES[@]}"
    do
        unlink $FILE
    done
}

# Fuction to print the usage and exit when there's bad input
function die () {
    echo "Usage ./manage.sh {install|remove|clean}"
    exit 1
}

# Make sure there is 1 command line argument
if [[ $# != 1 ]]; then
    die
fi

# Check whether the user is installing or removing
if [[ $1 == "install" ]]; then
    install_links
    ## It's required for this to have these permissions
    #chmod 0600 ~/.mutt/msmtprc
elif [[ $1 == "remove" ]]; then
    remove_links
elif [[ $1 == "clean" ]]; then
    find -L ~ -type l -maxdepth 1 -exec rm -i {} \;
else
    die
fi
