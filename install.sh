#==============
# Prepare variables
#==============

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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
