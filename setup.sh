#!/bin/sh
#root check

if ! [ $(id -u) = 0 ]; then
   echo -e "${RED}Plese run the script with root privilages!${ENDCOLOR}"
   exit 1
fi

clear
apt install figlet lolcat -y
apt install screenfetch -y
apt update -y
apt upgrade -y
clear
echo -e "  @@@@@@   @@@  @@@       @@@@@@@@  @@@  @@@  @@@@@@@     @@@  @@@  @@@@@@@   @@@  @@@  @@@  @@@  @@@  @@@  @@@@@@@  " | lolcat  
echo -e " @@@@@@@   @@@  @@@       @@@@@@@@  @@@@ @@@  @@@@@@@     @@@  @@@  @@@@@@@@  @@@@ @@@  @@@  @@@  @@@  @@@  @@@@@@@@ " | lolcat  
echo -e " !@@       @@!  @@!       @@!       @@!@!@@@    @@!       @@!  @@@  @@!  @@@  @@!@!@@@  @@!  @@@  @@!  @@@  @@!  @@@ " | lolcat  
echo -e " !@!       !@!  !@!       !@!       !@!!@!@!    !@!       !@!  @!@  !@!  @!@  !@!!@!@!  !@!  @!@  !@!  @!@  !@   @!@ " | lolcat  
echo -e " !!@@!!    !!@  @!!       @!!!:!    @!@ !!@!    @!!       @!@  !@!  @!@@!@!   @!@ !!@!  @!@!@!@!  @!@  !@!  @!@!@!@  " | lolcat  
echo -e "  !!@!!!   !!!  !!!       !!!!!:    !@!  !!!    !!!       !@!  !!!  !!@!!!    !@!  !!!  !!!@!!!!  !@!  !!!  !!!@!!!! " | lolcat 
echo -e "      !:!  !!:  !!:       !!:       !!:  !!!    !!:       :!:  !!:  !!:       !!:  !!!  !!:  !!!  !!:  !!!  !!:  !!! " | lolcat 
echo -e "     !:!   :!:   :!:      :!:       :!:  !:!    :!:        ::!!:!   :!:       :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:! " | lolcat  
echo -e " :::: ::    ::   :: ::::   :: ::::   ::   ::     ::         ::::     ::        ::   ::  ::   :::  ::::: ::   :: :::: " | lolcat  
echo -e " :: : :    :    : :: : :  : :: ::   ::    :      :           :       :        ::    :    :   : :   : :  :   :: : ::  " | lolcat 
echo ""
echo "Download Main Script. Please Wait...."
sleep 5
echo "Done .."
sleep 2
mkdir /etc/Sslablk
cd /etc/Sslablk
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/silentkiller365/SSH-Panel/main/install.sh; chmod 777 install.sh; bash install.
