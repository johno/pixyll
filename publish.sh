source .env
bundle exec ruby pocket.rb
git add .
CURRENTEPOCTIME=`date +Y-%m-%d %T`
git commit -m 'posts for $CURRENTEPOCTIME'
git push origin master
