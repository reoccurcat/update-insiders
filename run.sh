RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'
printf "${BLUE}                _      _           _         _    _            \n  _  _ _ __  __| |__ _| |_ ___ ___(_)_ _  __(_)__| |___ _ _ ___\n | || | '_ \/ _\` / _\` |  _/ -_)___| | ' \(_-< / _\` / -_) '_(_-<\n  \_,_| .__/\__,_\__,_|\__\___|   |_|_||_/__/_\__,_\___|_| /__/\n      |_|        \n\n${NC}"
printf "Getting ${RED}SUDO${NC} access...\n"
sudo printf "${GREEN}Achieved!${NC}\n"
if [ $? -gt 0 ]; then
    echo -e "${RED}Failed. Please rerun the script.${NC}"
    exit
fi
echo "$ pgrep -f 'code-insiders' >> /dev/null"
pgrep -f 'code-insiders' >> /dev/null
if [ $? -eq 0 ]; then
    echo -e "${BLUE}Insider instances running, killing...${NC}"
    pkill -e -f 'code-insiders'
    if [ $? -gt 0 ]; then
        echo -e "${RED}Failed to kill processes. ATTEMTING AS ROOT.${NC}"
        echo "# pkill -e -f 'code-insiders'"
        sudo pkill -e -f 'code-insiders'
        if [ $? -gt 0 ]; then
            echo -e "${RED}Failed.${NC}"
            exit
        fi
    fi
else
    echo -e "${BLUE}No insider instances running, continuing...${NC}"
fi
if [[ -d "/usr/share/vscode-insiders" ]]; then
    echo "# sudo rm -r /usr/share/vscode-insiders"
    sudo rm -r /usr/share/vscode-insiders
    echo "# mkdir /usr/share/vscode-insiders"
    sudo mkdir /usr/share/vscode-insiders
else
    echo "# mkdir /usr/share/vscode-insiders"
    sudo mkdir /usr/share/vscode-insiders
fi
echo "$ wget -nv 'https://code.visualstudio.com/sha/download?build=insider&os=linux-x64' -O /tmp/vscode-insiders.tar.gz"
wget -nv 'https://code.visualstudio.com/sha/download?build=insider&os=linux-x64' -O /tmp/vscode-insiders.tar.gz
echo "# tar xf /tmp/vscode-insiders.tar.gz -C /usr/share/vscode-insiders/  --strip-components 1"
sudo tar xf /tmp/vscode-insiders.tar.gz -C /usr/share/vscode-insiders/ --strip-components 1
if [[ -f "/usr/share/applications/code-insiders.desktop" ]]; then
    echo "# rm -r /usr/share/applications/code-insiders.desktop"
    sudo rm -r /usr/share/applications/code-insiders.desktop
fi
echo "# cp ./code-insiders.desktop /usr/share/applications/code-insiders.desktop"
sudo cp ./code-insiders.desktop /usr/share/applications/code-insiders.desktop
printf "${GREEN}All done! Check your application menu!${NC}\n"
exit
