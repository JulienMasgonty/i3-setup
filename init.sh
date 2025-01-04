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


  If you spot bugs, feel free to report them at :

   ________________________________________________
  |                                                |
  |   https://github.com/JulienMasgonty/i3-setup   |
  |                                                |
   ------------------------------------------------

EOF

logfile=$(pwd)/env-init.log
errfile=$(pwd)/env-init.error.log
now="$(date '+%Y/%m/%d %H:%M:%S')"
firstline="Executed on $now"

touch $logfile
touch $errfile
printf "$firstline\n" > $logfile
printf "$firstline\n" > $errfile


# -- General use apt packages
echo ""
echo "  ┏ Installing general use apt packages..."
(apt install -y \
	feh \
	xclip \
	python3-pip \ # for some reason python3 came preinstalled but not pip ?
	playerctl \
	git \
	btop \
	curl \
	wget \
	build-essential \
	libdbus-1-dev libdbus-glib-1-dev) & spin \
	"  ┗━━━" \
	"Waiting for installation to finish" \
	"Done" \
	"Error during installation"

echo "  ┏ Installing the GeistMono NerdFont..."
echo "  ┃"
mkdir -p ~/.local/share/fonts
echo "  ┣━━━ initializing ~/.local/share/fonts directory"
echo "  ┃"
(wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/GeistMono.zip) & spin \
	"  ┣━━━" \
	"Downloading GeistMono.zip from github..." \
	"GeistMono.zip downloaded successfully" \
	"failed to download GeistMono"
echo "  ┃"
cd ~/.local/share/fonts
(unzip GeistMono.zip && rm GeistMono.zip) & spin \
	"  ┣━━━" \
	"Extracting archive..." \
	"Archive extracted successfully" \
	"failed to extract archive"
echo "  ┃"
(fc-cache -f) & spin \
	"  ┣━━━" \
	"Regenerating fc-cache ..." \
	"fc-cache regenerated successfully" \
	"failed to regenerate fc-cache"
echo "  ┃"
echo "  ┗━━━ Done"


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
(mkdir -p $HOME/Workspace/Forks \
	&& git clone git@github.com:JulienMasgonty/ghostty.git ~/Workspace/Forks) & spin \
	"  ┣━━━" \
	"Iownloading ghostty..." \
	"ghostty downloaded" \
	"failed to download ghostty"
echo "  ┃" 
(cd $HOME/Workspace/Forks/ghostty \
	&& zig build -p $HOME/.local -Doptimize=ReleaseFast) & spin \
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
echo "  ┣━━━ Setting up dependencies for Lazy package manager"
echo "  ┃     ┃" 
(apt install lua5.4 liblua5.4-dev lua5.1 liblua5.1-dev) & spin \ # keeping lua 5.1 for now as Lazy requires it
	"  ┃     ┣━ " \
	"Installing lua..." \
	"Successfully installed lua" \
	"Error installing lua" \
echo "  ┃     ┃" 
echo "  ┃     ┣━ Setting up luarocks" 
echo "  ┃     ┃" 
(wget -P $(pwd)/_temp/ https://luarocks.org/releases/luarocks-3.11.1.tar.gz) \
	& spin \
	"  ┃     ┃     ┣━"
	"Downloading luarocks .tar archive" \
	"Successfully downloaded luarocks .tar archive" \
	"Error downloading luarocks .tar archive"
echo "  ┃     ┃     ┃" 
(cd $(pwd)/_temp && tar zxpf luarocks-3.11.1.tar.gz) \
	& spin \
	"  ┃     ┃     ┣━" \
	"Extracting luarocks-3.11.1.tar.gz" \
	"Successfully extracted luarocks-3.11.1.tar.gz" \
	"Error extracting luarocs-3.11.1.tar.gz"
echo "  ┃     ┃     ┃"
(./cd luarocks-3.11.1 && ./configure && make && make install) \
	& spin \
	"  ┃     ┃     ┗━"
	"installing luarocks" \
	"Successfully installed luarocks" \
	"Error installing luarocks"
echo "  ┃     ┃"
echo "  ┃     ┗━━━ Done"
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
	$HOME/.config/nvim \
	$HOME/.config/dunst \
	$HOME/_scripts/* \
	$HOME/.zshrc
echo "  ┃     ┣━ $HOME/.config/.i3"
echo "  ┃     ┣━ $HOME/.config/ghostty"
echo "  ┃     ┣━ $HOME/.config/polybar"
echo "  ┃     ┣━ $HOME/.config/nvim"
echo "  ┃     ┣━ $HOME/.config/dunst"
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

echo "  Reloading dunst"
killall dunst;notify-send "Dunst reloaded !"

echo "  All done, enjoy ! (⌐■_■)"
echo ""
exit 0
