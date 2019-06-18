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
