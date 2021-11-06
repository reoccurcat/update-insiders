RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LBLUE='\033[1;34m'
YELLOW='\033[1;33m'
PURPLE='\033[1;35m'
NC='\033[0m'
printf "${PURPLE}  _         _        _ _               _ _   _          \n (_)_ _  __| |_ __ _| | |___ _ __ _  _| | |_(_)_ __  __ \n | | ' \(_-<  _/ _\` | | |___| '  \ || | |  _| | '  \/ _|\n |_|_||_/__/\__\__,_|_|_|   |_|_|_\_,_|_|\__|_|_|_|_\__|${NC}\n\n"
printf "${LBLUE}(C) reoccurcat 2021-present using the GNU GPL v3 License${NC}\n\n"
if [[ -d "/usr/share/multimc-dev" ]]; then
    printf "${YELLOW}You already have MultiMC installed.\nIf you want to update it, please use the MultiMC application.\n${NC}"
    exit
fi
printf "Getting ${YELLOW}SUDO${NC} access...\n"
sudo printf "${GREEN}Achieved!${NC}\n"
if [ $? -gt 0 ]; then
    echo -e "${RED}Failed. Please rerun the script.${NC}"
    exit
fi
if [[ -d "/usr/share/multimc-dev" ]]; then
    echo "# sudo rm -r /usr/share/multimc-dev"
    sudo rm -r /usr/share/multimc-dev
fi
if [[ -d "/opt/multimc-dev" ]]; then
    echo "# sudo rm -r /opt/multimc-dev"
    sudo rm -r /opt/multimc-dev
    echo "# mkdir /opt/multimc-dev"
    sudo mkdir /opt/multimc-dev
else
    echo "# mkdir /opt/multimc-dev"
    sudo mkdir /opt/multimc-dev
fi
echo "$ wget -nv 'https://files.multimc.org/downloads/mmc-develop-lin64.tar.gz' -O /tmp/multimc-dev.tar.gz"
wget -nv 'https://files.multimc.org/downloads/mmc-develop-lin64.tar.gz' -O /tmp/multimc-dev.tar.gz
echo "# tar xf /tmp/multimc-dev.tar.gz -C /opt/multimc-dev/  --strip-components 1"
sudo tar xf /tmp/multimc-dev.tar.gz -C /opt/multimc-dev/ --strip-components 1
echo "# chmod -R 777 /opt/multimc-dev"
sudo chmod -R 777 /opt/multimc-dev
if [[ -f "/usr/share/applications/multimc-dev.desktop" ]]; then
    echo "# rm -r /usr/share/applications/multimc-dev.desktop"
    sudo rm -r /usr/share/applications/multimc-dev.desktop
fi
echo "# cp ./multimc-dev.desktop /usr/share/applications/multimc-dev.desktop"
sudo cp ./multimc-dev.desktop /usr/share/applications/multimc-dev.desktop
echo '$ grep -Fxq "alias multimc-dev=/opt/multimc-dev/MultiMC" ~/.bashrc'
grep -Fxq "alias multimc-dev=/opt/multimc-dev/MultiMC" ~/.bashrc
if [ $? -eq 1 ]; then
    echo -e "${BLUE}Alias not created, creating now...${NC}"
    echo "$ echo 'alias multimc-dev=/opt/multimc-dev/MultiMC' >> ~/.bashrc"
    echo 'alias multimc-dev=/opt/multimc-dev/MultiMC' >> ~/.bashrc
    echo '$ source ~/.bashrc'
    source ~/.bashrc
else
    echo -e "${BLUE}Alias already found, skipping...${NC}"
fi
printf "${GREEN}All done! Check your application menu! You can also run 'multimc-dev' to start it.${NC}\n"
exit
