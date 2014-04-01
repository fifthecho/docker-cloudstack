#!/bin/bash
cloudstack-setup-databases cloud:cloudstack@$DB_PORT_3306_TCP_ADDR --deploy-as=root:cloud -m cloudstack -k cloudstack
# cloudstack-setup-management
# service cloudstack-management stop
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-40to410.sql
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-40to410-cleanup.sql
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-410to420.sql cloud 
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-410to420-cleanup.sql cloud
sed -i.bak s/\-\-Add/\-\-\ Add/ /usr/share/cloudstack-management/setup/db/schema-420to421.sql
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-420to421.sql cloud
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-421to430.sql cloud
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack < /usr/share/cloudstack-management/setup/db/schema-421to430-cleanup.sql cloud
mysql -h $DB_PORT_3306_TCP_ADDR -u cloud -pcloudstack cloud -e "UPDATE version SET version = '4.3.0';"
cd /usr/share/cloudstack-management/bin
./catalina.sh run