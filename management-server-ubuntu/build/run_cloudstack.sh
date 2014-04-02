#!/bin/bash

test_for_db_config() {
  CONFIG_CHECK=`cat /etc/cloudstack/management/db.properties | grep db.cloud.host=localhost`
  if [ "$CONFIG_CHECK" == "db.cloud.host=localhost" ]; then
    echo "db.properties misconfigured. Fixing this."
    cloudstack-setup-databases cloud:cloudstack@$DB_PORT_3306_TCP_ADDR -m cloudstack -k cloudstack
    test_for_db_config
  else
    echo "Everything's good. Starting CloudStack."
    cd /usr/share/cloudstack-management/bin
    ./catalina.sh run
  fi
}

test_for_cloud_db() {
  RESULT=`mysqlshow --user=root --password=cloud --host=$DB_PORT_3306_TCP_ADDR | grep -o cloud | uniq`
  if [ "$RESULT" == "cloud" ]; then
    echo "Cloud DB exists. Starting CloudStack."
    test_for_db_config
  else
    echo "Cloud DB does not exist. Creating it."
    cloudstack-setup-databases cloud:cloudstack@$DB_PORT_3306_TCP_ADDR --deploy-as=root:cloud -m cloudstack -k cloudstack
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-40to410.sql
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-40to410-cleanup.sql
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-410to420.sql cloud 
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-410to420-cleanup.sql cloud
    sed -i.bak s/\-\-Add/\-\-\ Add/ /usr/share/cloudstack-management/setup/db/schema-420to421.sql
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-420to421.sql cloud
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-421to430.sql cloud
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-421to430-cleanup.sql cloud
    mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack cloud -e "UPDATE version SET version = '4.3.0', updated=now() WHERE id=1;"
    echo "DB Created."
    sleep 5
    test_for_cloud_db
  fi
}

test_for_cloud_db