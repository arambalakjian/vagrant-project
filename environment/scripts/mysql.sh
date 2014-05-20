#!/bin/bash

# Start of custom mysql_secure_installation definition

config=".my.cnf.$$"
command=".mysql.$$"
mysql_client=""

trap "interrupt" 1 2 3 6 15

rootpass=""
echo_n=
echo_c=

prepare() {
    touch $config $command
    chmod 600 $config $command
}

find_mysql_client()
{
  for n in ./bin/mysql mysql
  do  
    $n --no-defaults --help > /dev/null 2>&1
    status=$?
    if test $status -eq 0
    then
      mysql_client=$n
      return
    fi  
  done
  echo "Can't find a 'mysql' client in PATH or ./bin"
  exit 1
}

do_query() {
    echo "$1" >$command
    #sed 's,^,> ,' < $command  # Debugging
    $mysql_client --defaults-file=$config <$command
    return $?
}

remove_anonymous_users() {
    do_query "DELETE FROM mysql.user WHERE User='';"
    if [ $? -eq 0 ]; then
        echo " ... Success!"
    else
        echo " ... Failed!"
        clean_and_exit
    fi

    return 0
}

remove_remote_root() {
    do_query "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    if [ $? -eq 0 ]; then
        echo " ... Success!"
    else
        echo " ... Failed!"
    fi
}

remove_test_database() {
    echo " - Dropping test database..."
    do_query "DROP DATABASE test;"
    if [ $? -eq 0 ]; then
        echo " ... Success!"
    else
        echo " ... Failed!  Not critical, keep moving..."
    fi

    echo " - Removing privileges on test database..."
    do_query "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"
    if [ $? -eq 0 ]; then
        echo " ... Success!"
    else
        echo " ... Failed!  Not critical, keep moving..."
    fi

    return 0
}

reload_privilege_tables() {
    do_query "FLUSH PRIVILEGES;"
    if [ $? -eq 0 ]; then
        echo " ... Success!"
        return 0
    else
        echo " ... Failed!"
        return 1
    fi
}

cleanup() {
    echo "Cleaning up..."
    rm -f $config $command
}

# Remove the files before exiting.
clean_and_exit() {
        cleanup
        exit 1
}

# End of custom mysql_secure_installation definition

# Start of install script

echo "Installing MySQL"
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password '''
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password '''
apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql

echo
echo
mysql_install_db

#/usr/bin/mysql_secure_installation

echo
echo
echo "Beginning custom mysql_secure_installation"
prepare
find_mysql_client

echo
echo "Removing anonymous users"
remove_anonymous_users

echo
echo "Disallowing remote root login"
remove_remote_root

echo
echo "Removing test database"
remove_test_database

echo
echo "Reloading privlege tables"
reload_privilege_tables

cleanup

echo
echo
echo
echo "All done!  If you've completed all of the above steps, your MySQL"
echo "installation should now be secure."
echo
echo "Thanks for using MySQL!"
echo
echo


# find the DB folder
if [ -d /vagrant/database ]
then
	echo "Found folder 'database', using as db folder"
	DATABASE_FOLDER="database"
elif [ -d /vagrant/db ]
then
	echo "Found folder db, using as db folder"
	DATABASE_FOLDER="db"
else
	echo "Can't find db folder. Quitting..."
	exit 1
fi

DB_FILES=/vagrant/$DATABASE_FOLDER/*.sql
shopt -s nullglob
for file in $DB_FILES
do
	DB_NAME=`basename $file .sql`
	echo "Creating database '$DB_NAME'"
	# Drop the DB so that we can run the provisioner on a machine that already has had it run once
	mysql -u root <<< "DROP DATABASE IF EXISTS \`$DB_NAME\`; CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"

	echo "Importing database dump"
	sed '/^CREATE DATABASE/d;/^USE/d' $file | mysql $DB_NAME -u root
done;

echo "Databases imported"


#Reload the database
echo "Setting DB permissions for root"
mysql -u root <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo "MySQL installed"
