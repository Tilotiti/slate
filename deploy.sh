git add .
git commit -m "update"
git push
bundle exec middleman build --clean
echo "Fichiers générés, vous pouvez les charger sur le serveur."