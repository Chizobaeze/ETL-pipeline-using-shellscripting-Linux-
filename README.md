# Crypto Currency ETL Pipeline Using Bash
This is a simple ETL (Extract, Transform, Load) project I built using Bash scripting on a Linux environment. The goal was to practice automating data tasks without using Python or any fancy tools — just shell commands and logic.

The script pulls crypto data from the CoinStats API, processes it, and loads it into a MySQL database. I built this as part of my learning journey into data engineering and working with Linux tools.

## What the Script Does
Extract: Fetch cryptocurrency names and their values from the CoinStats API, saving the names to name_currency.txt and the values to values_currency.txt.

Transform: Add headers ("Name" and "Value") to both files, then merge them into a single CSV file called crypto_currency.csv.

Load: Connect to MySQL, create the database and table if they don’t exist, and load the CSV data into the crypto table using LOAD DATA LOCAL INFILE.

## Tools I Used
Curl (for making API requests).

Grep, sed, paste (for text processing).

MySQL.

Bash & .env file for environment variables.

## Setting Up
.env File I used a .env file to store my credentials and file paths. Here's what it looks like:

MYSQL_USER=root.

MYSQL_PASSWORD=your_mysql_password.

DATABASE=crypto_data.

CSV_PATH=/full/path/to/crypto_currency.csv.

## To run the script
chmod +x pipeline.sh Run the script:

./pipeline.sh If everything is correct, the data will be extracted, processed, and loaded into MySQL.

## Output: 
1. You’ll get a crypto_currency.csv file with the Name and Value of each currency.

2. The MySQL database will have a crypto table with the data.

 ## What I Learned
This project shows how to work with APIs using curl, process and clean data with Linux commands, load CSV data into MySQL, and securely manage sensitive information using environment variables.

## Things I Plan to Improve
Store the API key inside the .env file

Add proper error messages and logging

Schedule the script using cron

Add more columns from the API (like symbol, market cap, etc.)

Improve validation before loading the data
