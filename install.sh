#!/bin/sh
# Credits: SSH Tunnel Auto Script - By Project SSLaB LK 🇱🇰
# Version : 2.2.0

# Public IP
pub_ip=$(wget -qO- https://ipecho.net/plain ; echo)

apt update
apt upgrade -y

# Install required packages
apt install figlet lolcat -y
apt install screenfetch -y
apt install stunnel4 squid -y

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
echo "--- SSH Tunnel Auto Script ---" | lolcat
echo ""
echo "After this operation Stunnel / Dropbear / Squid / Badvpn Will be Installed on Your Server."
echo ""
echo ""
read -p "Do you want to continue? [y/n]" CONT
if [[ ! $CONT =~ ^[Yy]$ ]]; then
  echo "Abort."
  exit 100
fi

if [[ $EUID -ne 0 ]]; then
   echo -e "\e[95mYou must be root to do this.\e[0m" 1>&2
   exit 100
fi

echo -e "\e[96mInstalling dependancies\e[0m"
apt-get install -y libnss3* libnspr4-dev gyp ninja-build git cmake libz-dev build-essential 
apt-get install -y pkg-config cmake-data net-tools libssl-dev dnsutils speedtest-cli psmisc

echo -e "\e[96mChecking dropbear is installed\e[0m"
FILE=/etc/default/dropbear
if [ -f "$FILE" ]; then
    cp "$FILE" /etc/default/dropbear.bak
    rm "$FILE"
fi

echo -e "\e[96mCreating dropbear config\e[0m"
cat >> "$FILE" <<EOL
# disabled because OpenSSH is installed
# change to NO_START=0 to enable Dropbear
NO_START=0
# the TCP port that Dropbear listens on
DROPBEAR_PORT=444

# any additional arguments for Dropbear
DROPBEAR_EXTRA_ARGS="-p 80 -w -g"

# specify an optional banner file containing a message to be
# sent to clients before they connect, such as "/etc/issue.net"
DROPBEAR_BANNER="/etc/issue.net"

# RSA hostkey file (default: /etc/dropbear/dropbear_rsa_host_key)
#DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"

# DSS hostkey file (default: /etc/dropbear/dropbear_dss_host_key)
#DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"

# ECDSA hostkey file (default: /etc/dropbear/dropbear_ecdsa_host_key)
#DROPBEAR_ECDSAKEY="/etc/dropbear/dropbear_ecdsa_host_key"

# Receive window size - this is a tradeoff between memory and
# network performance
DROPBEAR_RECEIVE_WINDOW=65536
EOL

echo -e "\e[96mBackup old dropbear banner\e[0m"
FILE2=/etc/issue.net
if [ -f "$FILE2" ]; then
    cp "$FILE2" /etc/issue.net.bak
    rm "$FILE2"
fi

echo -e "\e[96mCreating dropbear banner\e[0m"
cat >> "$FILE2" <<EOL
<h1 style="text-align:center;"><span style="color:#1E90FF;">&#8734; █▓▒▒░░░SILENTVPNHUB░░░▒▒▓█&#8734;</span></h1>
<h3 style="text-align:center;"><span style="color:#20B2AA;">&#9734; PRIVATE SERVER &#9734;</span></h3>
<h4 style="text-align:center;"><span style="color:#8b00ff">========================<span style="color:#ffffff"></span></span></h4>
<h4 style="text-align:center;"><span style="color:#FF0000;">&#187; NO SPAM !!! &#171;</span></h4><h4 style="text-align:center;"><span style="color:#FF0000;">&#187; NO DDOS !!! &#171;</span></h4><h4 style="text-align:center;"><span style="color:#FF0000;">&#187; NO HACKING !!! &#171;</span></h4><h4 style="text-align:center;"><span style="color:#FF0000;">&#187; NO TORRENT !!! &#171;</span></h4><h4 style="text-align:center;"><span style="color:#FF0000;">&#187; NO OVER DOWNLOADING !!! &#171;</span></h4>
<h4 style="text-align:center;"><span style="color:#8b00ff">========================<span style="color:#ffffff"></span></span></h4>
<h5 style="text-align:center;"><span style="color:#FF6347;">&#9055; SSH PANEL 1.0 &#9055;</span></h5>
<h6 style="text-align:center;"><span style="color:#4863A0;">- Beta Version -</span></h6>
<h6 style="text-align:center;"><span style="color:#4863A0;">- 2019-2023 Copyright | SSLaB LK™ -</span></h6>
EOL

echo -e "\e[96mStarting dropbear services\e[0m"
/etc/init.d/dropbear start

echo -e "\e[96mChecking stunnel is installed\e[0m"
FILE3=/etc/stunnel/stunnel.conf
if [ -f "$FILE3" ]; then
    cp "$FILE3" /etc/stunnel/stunnel.conf.bak
    rm "$FILE3"
fi

echo -e "\e[96mCreating stunnel config\e[0m"
cat >> "$FILE3" <<EOL
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 443
connect = 444
EOL

echo -e "\e[96mCreating keys\e[0m"
KEYFILE=/etc/stunnel/stunnel.pem
if [ ! -f "$KEYFILE" ]; then
	openssl req -new -x509 -days 365 -nodes -out "$KEYFILE" -keyout "$KEYFILE"
fi

echo -e "\e[96mEnabling stunnel services\e[0m"
systemctl enable stunnel4

echo -e "\e[96mStarting stunnel services\e[0m"
systemctl start stunnel4

echo -e "\e[96mConfiguring squid\e[0m"
FILE5=/etc/squid/squid.conf
if [ -f "$FILE5" ]; then
    cp "$FILE5" /etc/squid/squid.conf.bak
    rm "$FILE5"
fi

echo -e "\e[96mConfiguring squid\e[0m"
cat >> "$FILE5" <<EOL
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst ${pub_ip}
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost
http_access deny all
http_port 8080
http_port 3128
coredump_dir /var/spool/squid
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
EOL

echo -e "\e[96mRestarting services. Please wait...\e[0m"
systemctl restart dropbear
systemctl restart stunnel4
systemctl restart squid

echo -e "\e[96mSSH Tunnel Setup Completed!\e[0m"
echo -e "\e[95mYou can access SSH panel using the 'menu' command.\e[0m"
echo -e "\e[95mReboot your VPS before use.\e[0m"
echo -e "Thank you for using this script."
echo -e "2019-2023 Copyright | █▓▒▒░░░SILENTVPNHUB░░░▒▒▓█"
