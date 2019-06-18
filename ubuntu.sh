
low_ram='512144' #

apt -y install gawk bc wget lsof

cpu_name=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cpu_cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
cpu_freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
server_ram_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
server_ram_mb=`echo "scale=0;$server_ram_total/1024" | bc`
server_hdd=$( df -h | awk 'NR==2 {print $2}' )
server_swap_total=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
server_swap_mb=`echo "scale=0;$server_swap_total/1024" | bc`
server_ip=$(ip route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q')
min_vession_ubuntu=15
current_version_ubuntu=$(printf '%d' $(lsb_release -sr) 2>/dev/null)

printf "=========================================================================\n"
echo "CPU : $cpu_name"
echo "CPU core : $cpu_cores"
echo "Speed core : $cpu_freq MHz"
echo "Total RAM : $server_ram_mb MB"
echo "Total swap : $server_swap_mb MB"
echo "Total disk : $server_hdd GB"
echo "IP server : $server_ip"
printf "=========================================================================\n"

if [ $server_ram_total -lt $low_ram ]; then
	echo -e "Error: RAM to low run Script \n (less 512MB) \n"
	echo "Bye..."
	exit
fi
if [ "$min_vession_ubuntu" -gt "$current_version_ubuntu" ]; then
	echo -e "Error: Version Ubuntu to low run Script upgrade ubuntu >= 16 \n"
	echo "Bye..."
	exit
fi
sleep 2

###clear
printf "=========================================================================\n"
printf "Start setup... \n"
printf "=========================================================================\n"

read -r -p "Are you sure setup ? [y/N] " response
	case $response in
	    [nN]|[nN])
            echo "Bye exit setup !"
	        exit
	        ;;
	    *)

	        echo "run...."

	        ;;
	esac

#rm -f /etc/localtime
#ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime

apt install selinux-utils -y
setenforce 0

apt -y update
apt -y upgrade

###clear
printf "=========================================================================\n"
printf "Prepare done start setup server... \n"
printf "=========================================================================\n"
sleep 2

apt install gnupg2 && apt update -y && apt upgrade -y && apt install zip -y && apt install -y libmagickwand-dev && apt install libmysqlclient-dev -y && apt install unzip -y && apt install git -y && git config --global user.name "ruby rails git" && git config --global user.email "ruby@localhost" && git config --list  && sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev -y && apt install nginx -y && sudo ufw allow 'Nginx HTTP' && systemctl start nginx && systemctl enable nginx && apt install nodejs -y && command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import - && command curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import - && curl -L get.rvm.io | bash -s stable && source /etc/profile.d/rvm.sh && rvm reload && rvm requirements run && rvm install ruby --latest && rvm use ruby --latest --default && ruby -v && gem install bundler && gem install rmagick && gem install mysql2 && gem install rails --no-document && ruby -v && rails -v

# Install more
apt -y install unzip zip nano openssl ntpdate

ntpdate asia.pool.ntp.org
hwclock --systohc

###clear
printf "=========================================================================\n"
printf "Config done ... \n"
printf "=========================================================================\n"


apt install ufw -y
sudo ufw allow ssh
sudo ufw allow 22
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 25/tcp
sudo ufw allow 465/tcp
sudo ufw allow 587/tcp
sudo ufw allow 3306/tcp

ruby -v
rails -v

printf "Scripts Rubyra (Ruby On Rails) help setup done... \n"
printf "=========================================================================\n"
printf "Need support , contact https://rubyra.com/\n"
printf "=========================================================================\n"
printf "Server will reboot after 3s .... \n\n"
sleep 3
reboot
exit
