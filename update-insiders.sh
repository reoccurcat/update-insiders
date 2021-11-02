#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LBLUE='\033[1;34m'
YELLOW='\033[1;33m'
PURPLE='\033[1;35m'
NC='\033[0m'
quiet='false'
printf "${PURPLE}                _      _           _         _    _            \n  _  _ _ __  __| |__ _| |_ ___ ___(_)_ _  __(_)__| |___ _ _ ___\n | || | '_ \/ _\` / _\` |  _/ -_)___| | ' \(_-< / _\` / -_) '_(_-<\n  \_,_| .__/\__,_\__,_|\__\___|   |_|_||_/__/_\__,_\___|_| /__/\n      |_|        \n${NC}"
printf "${LBLUE}(C) reoccurcat 2021-present using the GNU GPL v3 License${NC}\n\n"
print_usage() {
  echo -e "Command help\n-q  Runs non-verbosely"
  exit 1
}
while getopts 'hq' flag; do
  case "${flag}" in
    q) quiet='true' ;;
    h) print_usage ;;
  esac
done
if [ $quiet == 'true' ]; then
  sudo echo >> /dev/null
  if [ $? -gt 0 ]; then
      echo -e "${RED}Failed to get sudo access. Please rerun the script.${NC}"
      exit
  fi
  pgrep -f 'code-insiders' >> /dev/null
  if [ $? -eq 0 ]; then
    pkill -f 'code-insiders'
    if [ $? -gt 0 ]; then
      sudo pkill -e -f 'code-insiders'
      if [ $? -gt 0 ]; then
        echo -e "${RED}Failed.${NC}"
        read -n 1 -s -r -p "Press any key to continue."
        exit
      fi
    fi
  fi
  if [[ -d "/usr/share/vscode-insiders" ]]; then
      sudo rm -r /usr/share/vscode-insiders
      sudo mkdir /usr/share/vscode-insiders
  else
      sudo mkdir /usr/share/vscode-insiders
  fi
  wget -nv 'https://code.visualstudio.com/sha/download?build=insider&os=linux-x64' -O /tmp/vscode-insiders.tar.gz
  sudo tar xf /tmp/vscode-insiders.tar.gz -C /usr/share/vscode-insiders/ --strip-components 1
  if [[ -f "/usr/share/applications/code-insiders.desktop" ]]; then
      sudo rm -r /usr/share/applications/code-insiders.desktop
  fi
  sudo cp ./code-insiders.desktop /usr/share/applications/code-insiders.desktop
  grep -Fxq "alias code-insiders=/usr/share/vscode-insiders/bin/code-insiders" ~/.bashrc
  if [ $? -eq 1 ]; then
      source ~/.bashrc
  fi
  printf "${GREEN}Completed.${NC}\n"
  read -n 1 -s -r -p "Press any key to continue."
  exit
else
  printf "Getting ${YELLOW}SUDO${NC} access...\n"
  sudo printf "${GREEN}Achieved!${NC}\n"
  if [ $? -gt 0 ]; then
      echo -e "${RED}Failed. Please rerun the script.${NC}"
      exit
  fi
  echo "$ pgrep -f 'code-insiders' >> /dev/null"
  pgrep -f 'code-insiders' >> /dev/null
  if [ $? -eq 0 ]; then
      echo -e "${YELLOW}Insider instances are running.${NC}"
      while true
      do
        read -r -p "Do you want to kill them? [Y/n] " input
        case $input in
          [yY][eE][sS]|[yY])
        echo "$ pkill -e -f 'code-insiders'"
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
  echo '$ grep -Fxq "alias code-insiders=/usr/share/vscode-insiders/bin/code-insiders" ~/.bashrc'
  grep -Fxq "alias code-insiders=/usr/share/vscode-insiders/bin/code-insiders" ~/.bashrc
  if [ $? -eq 1 ]; then
      echo -e "${BLUE}Alias not created, creating now...${NC}"
      echo "$ echo 'alias code-insiders=/usr/share/vscode-insiders/bin/code-insiders' >> ~/.bashrc"
      echo 'alias code-insiders=/usr/share/vscode-insiders/bin/code-insiders' >> ~/.bashrc
      echo '$ source ~/.bashrc'
      source ~/.bashrc
  else
      echo -e "${BLUE}Alias already found, skipping...${NC}"
  fi
  printf "${GREEN}All done! Check your application menu! You can also run 'code-insiders' to start it.${NC}\n"
  exit
fi