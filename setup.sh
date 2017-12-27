read -p "jcForum requires MySQL database access. What is the MySQL username (i.e, root)" dbUser
read -p "What is the MySQL password?" dbPassword

$(mysql -u$dbUser -p$dbPassword -se "CREATE DATABASE jcForum")

sudo mkdir /lib/jcForum
sudo echo "\$mysqli = new mysqli(\"127.0.0.1\", \"$dbUser\", \"$dbPassword\", \"jcForum\");" | sudo tee /lib/jcForum/mysql.php

$(mysql jcForum -u$dbUser -p$dbPassword -se "CREATE TABLE forumInfo (path varchar(128));")
read -p "What path should your forum be at (i.e, /path/to/server/forum)" path
$(mysql jcForum -u$dbUser -p$dbPassword -se "INSERT INTO forumInfo (path) VALUES ('$path')")
