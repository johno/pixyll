source .env
bundle exec ruby pocket.rb
git add .
CURRENTDATE=`date +"%Y-%m-%d %T"`
git commit -m 'posts for ${CURRENTDATE}'
git push origin master
