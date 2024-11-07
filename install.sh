#==============
# Prepare variables
#==============

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*|MINGW*|MINGW32*|MSYS*)  machine=Windows;;
esac

if [ "$machine" == "Mac" ]
	then
#==============
# Update brew
#==============

brew doctor
brew update

#==============
# Install brew packages
#==============

brew install nvim
brew install wezterm

#==============
# Delete old configs
#==============

# Remove wezterm config
sudo rm -rf ~/.config/wezterm > /dev/null 2>&1

# Remove nvim config
sudo rm -rf ~/.config/nvim > /dev/null 2>&1

#==============
# Create symlinks of source files 
#==============

ln -sf $SCRIPT_DIR/mac ~/.config

elif [ "$machine" == "Windows" ]
	then
		
#==============
# Delete old configs
#==============

# Remove wezterm config
sudo rm -rf ~/.config/wezterm > /dev/null 2>&1

# Remove nvim config
sudo rm -rf ~/AppData/Local/nvim > /dev/null 2>&1

#==============
# Create symlinks of source files 
#==============

ln -sf $SCRIPT_DIR/windows/wezterm ~/.config

ln -sf $SCRIPT_DIR/windows/nvim ~/AppData/Local

fi
