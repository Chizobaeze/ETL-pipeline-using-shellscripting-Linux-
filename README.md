
# Crypto Currency ETL Pipeline Using Bash
This is a simple ETL (Extract, Transform, Load) project I built using Bash scripting on a Linux environment. The goal was to practice automating data tasks without using Python or any fancy tools — just shell commands and logic.

The script pulls crypto data from the CoinStats API, processes it, and loads it into a MySQL database. I built this as part of my learning journey into data engineering and working with Linux tools.

# 🛠️ What the Script Does
1. Extract: Gets cryptocurrency names and their values using the CoinStats API.
Saves the names in a file called name_currency.txt.
Saves the values in a separate file called values_currency.txt.

2. Transform: Adds headers to both files (Name and Value).
Merges the two into one CSV file: crypto_currency.csv.

3. Load: Connects to MySQL.
Creates a database and a table if they don’t exist.
Loads the CSV data into the crypto table using LOAD DATA LOCAL INFILE.

# 🧰 Tools I Used
Curl (for making API requests).

Grep, sed, paste (for text processing).

MySQL.

Bash & .env file for environment variables.

## ⚙️ Setting Up
.env File
I used a .env file to store my credentials and file paths. Here's what it looks like:

MYSQL_USER=root.

MYSQL_PASSWORD=your_mysql_password.

DATABASE=crypto_data.

CSV_PATH=/full/path/to/crypto_currency.csv.

