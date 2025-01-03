#!/bin/bash

# TODO : split this init script into multiple smaller, dedicated scripts

# unicode chars used for styling :
#
#  ┃ ┏ ┓ ┗ ┛ ┣ ┫ ┳ ┻ ╋ ━ √ × … • ? !
#

# TODO : make this its own helper script ?
# usage : (sleep 5) & spin "" "waiting for task to be completed" "task completed !" "error :("
spin() {
	local prefix=$1
	local info=$2
	local success=$3
	local error=$4
	local pid=$!
	local delay=0.1
	local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
	local charwidth=1
	
	local reset="\b\b\b\b\b\b"
	for ((i=1; i<=$(echo $info | wc -c); i++)); do
		reset+="\b"
	done
	
	local i=0
	tput civis # is supposed to hide the cursor
	while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
		printf $reset
		local i=$(((i + $charwidth) % ${#spin}))
		printf "%s \033[0;36m%s\033[0m %s" "$prefix" "${spin:$i:$charwidth}" "$info"
		local spin=$temp${spin%"$temp"}
		sleep $delay
	done
	wait "$pid"; exitCode=$? # get the awaited process' return code

	if [ $exitCode -eq 0 ]; then
		printf "\r\033[K%s \033[0;32m√\033[0m %s" "$prefix" "$success"
	else
		printf "\r\033[K%s \033[0;31m×\033[0m %s" "$prefix" "$error"
		tput cnorm
		exit 1
	fi

	echo "" # gets rid of the % at the end, don't know why
	tput cnorm # retore the cursor
	return 0
}

cat << EOF


         ____    ____   ____    ___________    __________    ________________
        |    |  |    | |    |  |           |  |          |  |                |
        |    |  |     -     |  |     _     |  |          |  |                |
        |    |  |           |  |    | |    |  |     -----   |     -----------
        |    |  |     _     |  |     -     |  |    |        |    |
 ___    |    |  |    | |    |  |           |  |     -----   |    |    _______
|   |   |    |  |    | |    |  |     _     |  |          |  |    |   |       |
|   |   |    |  |    | |    |  |    | |    |  |_____     |  |    |    --     |
|   |   |    |  |    | |    |  |    | |    |        |    |  |    |      |    |
|    ---     |  |    | |    |  |    | |    |   -----     |  |     ------     |
|            |  |    | |    |  |    | |    |  |          |  |                |
|            |  |    | |    |  |    | |    |  |          |  |                |
 ------------    ----   ----    ----   ----    ----------    ----------------

			- Initializing environment -

EOF

(sleep 5) & spin \
	"" \
	"Waiting for task" \
	"task finished" \
	"error"


# (sleep 5 & alezh) & spin \
#	"" \
#	"Waiting for task" \
#	"task finished" \
#	"error"

logfile=$(pwd)/env-init.log
errfile=$(pwd)/env-init.error.log
now="$(date '+%Y/%m/%d %H:%M:%S')"
firstline="Executed on $now"

touch $logfile
touch $errfile
printf "$firstline\n" > $logfile
printf "$firstline\n" > $errfile

echo ""
exit 0


# -- General use apt packages
echo ""
echo "  ┏ Installing general use apt packages..."
(apt install -y \
	feh \
	git \
	btop \
	curl) & spin \
	"  ┗━━━" \
	"Waiting for installation to finish" \
	"Done" \
	"Error during installation"


# -- Polybar
echo "  ┏ Installing polybar" 
echo "  ┃" 
(apt install -y polybar) & spin \
	"  ┗━━━" \
	"Installing polybar..." \
	"polybar installed successfully" \
	"failed to install polybar"


# -- Ghostty
echo "  ┏ Installing ghostty"
echo "  ┃" 
(snap install zig --classic --beta) & spin \
	"  ┣━━━" \
	"Installing zig..." \
	"zig installed successfully" \
	"failed to install zig"
echo "  ┃" 
(sudo apt install -y libgtk-4-dev libadwaita-1-dev) & spin \
	"  ┣━━━" \
	"Installing dependencies..." \
	"dependencies installed successfully" \
	"failed to install dependencies"
echo "  ┃" 
(mkdir -p $HOME/Workspace/Forks & \
	git clone git@github.com:JulienMasgonty/ghostty.git ~/Workspace/Forks) & spin \
	"  ┣━━━" \
	"Iownloading ghostty..." \
	"ghostty downloaded" \
	"failed to download ghostty"
echo "  ┃" 
(cd $HOME/Workspace/Forks/ghostty &  \
	zig build -p $HOME/.local -Doptimize=ReleaseFast) & spin \
	"  ┣━━━" \
	"Building ghostty from source..." \
	"built ghostty from source" \
	"error building ghostty from source"
echo "  ┃" 
echo "  ┗━━━ Done"
echo ""


# -- Nvim
# TODO : setup nvim here
echo "  ┏ Installing Neovim"
echo "  ┃" 
(curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz) \
	& spin \
	"  ┣━━━" \
	"Downloading neovim..." \
	"Neovim downloaded successfully" \
	"Error downloading neovim"
echo "  ┃" 
echo "  ┣━━━ Purging existing neovim installation"
sudo rm -rf /opt/nvim
echo "  ┃     ┗━ /opt/nvim"
echo "  ┃" 
(sudo tar -C /opt -xzf nvim-linux64.tar.gz) & spin \
	"  ┣━━━" \
	"Extracting neovim..." \
	"Successfully extracted neovim into /opt/nvim" \
	"Error extracting neovim"
echo "  ┃" 
echo "  ┗━━━ Done"
echo ""


# -- Config files
# TODO : keep track of symlinks to create in a dedicated file and refactor this
echo "  ┏ Setting up symlinks to configuration files..."
echo "  ┃" 
echo "  ┣━━━ Initialising directories"
mkdir -p $HOME/.config/
mkdir -p $HOME/_scripts
echo "  ┃     ┣━ Created $HOME/.config/"
echo "  ┃     ┗━ Created $HOME/_scripts"
echo "  ┃" 
echo "  ┣━━━ Purging default files"
rm -rf $HOME/.config/i3 \
	$HOME/.config/ghostty \
	$HOME/.config/polybar \
	$HOME/_scripts/* \
	$HOME/.zshrc
echo "  ┃     ┣━ $HOME/.config/.i3"
echo "  ┃     ┣━ $HOME/.config/ghostty"
echo "  ┃     ┣━ $HOME/.config/polybar"
echo "  ┃     ┣━ $HOME/_scripts/*"
echo "  ┃     ┗━ $HOME/.zshrc"
echo "  ┃" 
echo "  ┣━━━ Setting i3 config files" 
ln -s $(pwd)/i3 $HOME/.config/i3
echo "  ┃     ┗━ $(pwd)/i3 -> $HOME/.config/i3"
echo "  ┃" 
echo "  ┣━━━ Setting ghostty config files" 
ln -s $(pwd)/ghostty $HOME/.config/ghostty
echo "  ┃     ┗━ $(pwd)/ghostty -> $HOME/.config/ghostty"
echo "  ┃" 
echo "  ┣━━━ Setting polybar config files" 
ln -s $(pwd)/ghostty $HOME/.config/ghostty
echo "  ┃     ┣━ $(pwd)/polybar -> $HOME/.config/polybar"
echo "  ┃" 
echo "  ┣━━━ Setting neovim config files" 
ln -s $(pwd)/ghostty $HOME/.config/ghostty
echo "  ┃     ┣━ $(pwd)/nvim -> $HOME/.config/nvim"
echo "  ┃" 
echo "  ┣━━━ Setting .zshrc" 
ln -s $(pwd)/.zshrc $HOME/.zshrc
echo "  ┃     ┗━ $(pwd)/.zshrc -> $HOME/.zshrc"
echo "  ┃" 
echo "  ┣━━━ Setting scripts" 
chmod a+x $(pwd)/_scripts/*.sh
ln -s $(pwd)/_scripts $HOME/_scripts
echo "  ┃     ┗━ $(pwd)/_scripts -> $HOME/_scripts"
echo "  ┃" 
echo "  ┗━━━ Done"
echo ""

echo "  Reloading i3 configuration"
i3-msg reload

echo "  All done, enjoy ! (⌐■_■)"
echo ""
exit 0
