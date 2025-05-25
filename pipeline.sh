

#!/bin/bash

set -a
source .env
set +a



echo "extracting currency name file e.g USD"

curl --request GET \
     --url https://openapiv1.coinstats.app/currencies \
     --header 'X-API-KEY: rr5TW0kV6UbSp+AbbYudt2DKUm2KrDlIPRsSHHe7kBE=' \
     --header 'accept: application/json' \
2>/dev/null | grep -oE  '"[A-Z]{3}"' | sed 's/"//g'  > name_currency.txt

echo "extracting currency values file"

curl --request GET \
     --url https://openapiv1.coinstats.app/currencies \
     --header 'X-API-KEY: rr5TW0kV6UbSp+AbbYudt2DKUm2KrDlIPRsSHHe7kBE=' \
     --header 'accept: application/json' \
2>/dev/null | grep -oE '[0-9]+(\.[0-9]+)?' | sed 's/"//g' > values_currency.txt


echo  " adding headers to both txt files"
sed -i '1iName'  name_currency.txt
sed -i '1iValue' values_currency.txt


echo "transforming the txt files by merging them together into a csv file eg crypto_currency.csv"
paste -d ',' name_currency.txt  values_currency.txt > crypto_currency.csv



echo "loading data into mysql database"

echo "loading data into mysql database"


# Enable local infile
MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -e  "SET GLOBAL local_infile = 1;"

# Create database
MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -e "CREATE DATABASE IF NOT EXISTS $DATABASE;"

# Drop and recreate table
MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -e  "
DROP TABLE IF EXISTS crypto;
CREATE TABLE crypto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Value DECIMAL(10,2)
);
"

# Load data
MYSQL_PWD="$MYSQL_PASSWORD" mysql --local-infile=1 -u "$MYSQL_USER" -D "$DATABASE" -e  "
LOAD DATA LOCAL INFILE '$CSV_PATH'
INTO TABLE crypto
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Name, Value);
"
echo "Done. Data loaded successfully into the MySQL database."

MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -D "$DATABASE" -e "SELECT * FROM crypto LIMIT 1;"
