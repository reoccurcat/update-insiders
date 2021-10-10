RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LBLUE='\033[1;34m'
YELLOW='\033[1;33m'
PURPLE='\033[1;35m'
NC='\033[0m'
printf "${PURPLE}                _      _                     _ _   _          \n  _  _ _ __  __| |__ _| |_ ___ ___ _ __ _  _| | |_(_)_ __  __ \n | || | '_ \/ _\` / _\` |  _/ -_)___| '  \ || | |  _| | '  \/ _|\n  \_,_| .__/\__,_\__,_|\__\___|   |_|_|_\_,_|_|\__|_|_|_|_\__|\n      |_|${NC}\n\n"
printf "${LBLUE}(C) reoccurcat 2021-present using the GNU GPL v3 License${NC}\n\n"
printf "Getting ${YELLOW}SUDO${NC} access...\n"
sudo printf "${GREEN}Achieved!${NC}\n"
if [ $? -gt 0 ]; then
    echo -e "${RED}Failed. Please rerun the script.${NC}"
    exit
fi
echo "$ pgrep -f 'multimc' >> /dev/null"
pgrep -f 'multimc' >> /dev/null
if [ $? -eq 0 ]; then
    echo -e "${YELLOW}multimc instances are running.${NC}"
    while true
    do
      read -r -p "Do you want to kill them? [Y/n] " input
      case $input in
        [yY][eE][sS]|[yY])
      echo "$ pkill -e -f 'multimc'"
      pkill -e -f 'multimc'
      if [ $? -gt 0 ]; then
        echo -e "${RED}Failed to kill processes. ATTEMTING AS ROOT.${NC}"
        echo "# pkill -e -f 'multimc'"
        sudo pkill -e -f 'multimc'
        if [ $? -gt 0 ]; then
          echo -e "${RED}Failed.${NC}"
          exit
        fi
      fi
      break
      ;;
        [nN][oO]|[nN])
      echo -e "${RED}CONTINUE AT YOUR OWN RISK. FILE CORRUPTION IS POSSIBLE.${NC}"
        while true
        do
          read -r -p "Are you sure you want to continue? [Y/n] " input
          case $input in
            [yY][eE][sS]|[yY])
          echo -e "${RED}YOU HAVE BEEN WARNED.${NC}"
          break
          ;;
            [nN][oO]|[nN])
          echo -e "${BLUE}Exiting...${NC}"
          exit
                 ;;
              *)
          echo -e "${YELLOW}Invalid input.${NC}"
          ;;
          esac
        done
        break
                ;;
             *)
        echo -e "${YELLOW}Invalid input.${NC}"
          ;;
          esac
        done
else
    echo -e "${BLUE}No multimc instances running, continuing...${NC}"
fi
if [[ -d "/usr/share/multimc-dev" ]]; then
    echo "# sudo rm -r /usr/share/multimc-dev"
    sudo rm -r /usr/share/multimc-dev
    echo "# mkdir /usr/share/multimc-dev"
    sudo mkdir /usr/share/multimc-dev
else
    echo "# mkdir /usr/share/multimc-dev"
    sudo mkdir /usr/share/multimc-dev
fi
echo "$ wget -nv 'https://files.multimc.org/downloads/mmc-develop-lin64.tar.gz' -O /tmp/multimc-dev.tar.gz"
wget -nv 'https://files.multimc.org/downloads/mmc-develop-lin64.tar.gz' -O /tmp/multimc-dev.tar.gz
echo "# tar xf /tmp/multimc-dev.tar.gz -C /usr/share/multimc-dev/  --strip-components 1"
sudo tar xf /tmp/multimc-dev.tar.gz -C /usr/share/multimc-dev/ --strip-components 1
echo "# chmod -R 777 /usr/share/multimc-dev"
sudo chmod -R 777 /usr/share/multimc-dev
if [[ -f "/usr/share/applications/multimc-dev.desktop" ]]; then
    echo "# rm -r /usr/share/applications/multimc-dev.desktop"
    sudo rm -r /usr/share/applications/multimc-dev.desktop
fi
echo "# cp ./multimc-dev.desktop /usr/share/applications/multimc-dev.desktop"
sudo cp ./multimc-dev.desktop /usr/share/applications/multimc-dev.desktop
echo '$ grep -Fxq "alias multimc-dev=/usr/share/multimc-dev/MultiMC" ~/.bashrc'
grep -Fxq "alias multimc-dev=/usr/share/multimc-dev/MultiMC" ~/.bashrc
if [ $? -eq 1 ]; then
    echo -e "${BLUE}Alias not created, creating now...${NC}"
    echo "$ echo 'alias multimc-dev=/usr/share/multimc-dev/MultiMC' >> ~/.bashrc"
    echo 'alias multimc-dev=/usr/share/multimc-dev/MultiMC' >> ~/.bashrc
    echo '$ source ~/.bashrc'
    source ~/.bashrc
else
    echo -e "${BLUE}Alias already found, skipping...${NC}"
fi
printf "${GREEN}All done! Check your application menu! You can also run 'multimc-dev' to start it.${NC}\n"
exit
