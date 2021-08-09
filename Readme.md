# Problem description
Developing a social media application which can be used to share information with other people. This application will only be used by people that work in a certain company so they cannot use existing public social media.

# setup
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y  
apt-get install -y dialog mercurial gcc-multilib git cmake g++  
apt-get install -y curl libunwind-dev nano  
apt-get install -y build-essential cmake git gnupg golang libpcre3-dev zlib1g-dev libcurl4-openssl-dev libssl-dev  
apt-get install -y pkg-config build-essential autoconf bison re2c libxml2-dev libsqlite3-dev  
apt-get install -y gcc-8-base apt-utils  
apt-get install locales bash-completion nano git zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg2 apt-transport-https ca-certificates net-tools  
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -  
apt install -y nodejs  
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list  
apt update && apt install yarn  
cd  
git clone https://github.com/rbenv/rbenv.git ~/.rbenv  
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc  
echo 'eval "$(rbenv init -)"' >> ~/.bashrc  
exec $SHELL  
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build  
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc  
exec $SHELL  
rbenv install 3.0.2  
rbenv global 3.0.2  
gem install bundler  
apt install -y mariadb-server mariadb-client default-libmysqlclient-dev  
gem install mysql2  
sudo systemctl disable mysql  
sudo systemctl enable mariadb.service  
gem install rerun  
gem install rails  
gem install rspec  
gem install simplecov  
gem install sinatra  
gem install thin  
gem install puma  
gem install reel  
gem install http  
gem install webrick  

# Installations
cd  
git clone https://github.com/simopunkc/final-project-generasi-gigih.git  
cd final-project-generasi-gigih  
rspec --init  


# Usages
rerun main.rb