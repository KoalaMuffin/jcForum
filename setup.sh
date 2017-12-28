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

askUser()
{
  read -p "Would you like a dedicated user database (d) or would you like to link it to an existing one (l)?" userTable
  if [ "$userTable" == "l" ]
  then
    read -p "The user table you are linking to MUST use on of the following encyrption methods: sha256, sha512, or MD5. It can also use no encryption. It CANNOT use salt. Proceed (Y)?" confirmLink
    if [ "$confirmLink" != "Y" ]
    then
      askUser
    fi
  fi
}
askUser
