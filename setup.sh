read -p "jcForum requires MySQL database access. Enter the MySQL username. (I.e, root.)" dbUser
read -p "What is the MySQL password?" dbPassword

$(mysql -u$dbUser -p$dbPassword -se "CREATE DATABASE jcForum")

sudo mkdir /lib/jcForum
sudo echo "\$mysqli = new mysqli(\"127.0.0.1\", \"$dbUser\", \"$dbPassword\", \"jcForum\");" | sudo tee /lib/jcForum/mysql.php

$(mysql jcForum -u$dbUser -p$dbPassword -se "CREATE TABLE forumInfo (path varchar(128));")
read -p "Enter where path should your forum be at such as /path/to/server/forum." path
sudo mkdir $path
$(mysql jcForum -u$dbUser -p$dbPassword -se "TRUNCATE TABLE forumInfo")
$(mysql jcForum -u$dbUser -p$dbPassword -se "INSERT INTO forumInfo (path) VALUES ('$path')")

echo "Would you like a dedicated user database or would you like to link it to an existing one?\n"
