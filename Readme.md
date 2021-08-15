## Problem description
Developing a social media application which can be used to share information with other people. This application will only be used by people that work in a certain company so they cannot use existing public social media. The application will be an API-only application.

## Scope
1. As a user, I want to save my username, email, and bio description.  
- Authentication and authorization is out of scope of this story and you don’t need to implement them  
2. As a user, I want to post a text that might contain hashtag(s).  
- Maximum limit of a text is 1000 characters  
- A hashtag is a text that is followed by # symbol, for instance: #generasigigih  
3. As a user, I want to see all posts that contain a certain hashtag.  
- A user can only filter by one hashtag name at a time  
4. As a user, I want to see the list of trending hashtags.  
- Trending hashtags are the top 5 most posted hashtags in the past 24 hours  
- A post containing multiple instances of a hashtag only counts as 1 occurrence for trending hashtags calculation  
5. As a user, I want to comment on a post  
- A comment can contain hashtag(s)  
- A hashtag occurrence in a comment is counted in trending hashtags calculation  
6. As a user, I want to attach things to a post  
- Three kinds of attachment are allowed: pictures (jpg, png, gif), video (mp4), and file (any other extensions outside of pictures and videos)  

## setup
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y  
apt-get install -y dialog mercurial gcc-multilib git cmake g++  
apt-get install -y curl libunwind-dev nano  
apt-get install -y build-essential cmake git gnupg golang libpcre3-dev zlib1g-dev libcurl4-openssl-dev libssl-dev  
apt-get install -y pkg-config build-essential autoconf bison re2c libxml2-dev libsqlite3-dev  
apt-get install -y gcc-8-base apt-utils  
apt-get install locales bash-completion nano git zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg2 apt-transport-https ca-certificates net-tools  
sudo mkdir /root/.ssh  
sudo cp ~/.ssh/authorized_keys /root/.ssh/authorized_keys  
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
gem install mimemagic  
gem install travis  
apt install ansible  

## Notes: reset the Database before running test
mysql -u root < database_reset.sql  
mysql -u root db_generasigigih < database.sql  

## Testing
#### Coverage should be 100% & Postman test should be Passed 100%
rspec --init  
rspec spec/  

## localhost usage
rerun main.rb