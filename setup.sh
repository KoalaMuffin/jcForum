read "jcForum requires MySQL database access. What is the MySQL username (i.e, root)" -r $dbUser
read "What is the MySQL password?" -r $dbPassword

$(mysql -u$dbUser -p$dbPassword -se "CREATE DATABASE jcForum")

sudo mkdir /jcForum
sudo echo "\$mysqli = new mysqli(\"127.0.0.1\", \"$dbUser\", \"$dbPassword\", \"jcForum\");" > /jcForum/mysql.php
