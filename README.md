# DataSystemsYelp

## About
This repository contains instructions and queries for Soen 363 Data systems class project phase 2.</br> 
The purpose of this project is to investage NoSQL database systems on a dataset. </br>
Our NoSQL system was <a href="https://www.mongodb.com/"> MongoDB</a> and the dataset of choice was the <a href="https://www.yelp.com/dataset"> Yelp Open Dataset </a>.</br>

## Installation
The installation was conducted on a Virtual Machine running Ubuntu 18.04. </br>
From the terminal, issue the following command to import the MongoDB public GPG key:</br>
```
$ wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
```

Create the list file /etc/apt/sources.list.d/mongodb-org-4.2.list for your version of Ubuntu:
```
$ echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
```


Reload the local package database:
```
$ sudo apt-get update
```

Install the MongoDB packages:
```
$ sudo apt-get install -y mongodb-org
```

To begin using the mongo shell:
```
$ mongo
```


## Loading the Dataset
Provide your information, agree to Dataset Licence and download the 9.71 gb datset from https://www.yelp.com/dataset </br>
Once downloaded, unzip download folder into the same directory as the DataSystemsYelp repository. </br>

From the mongo shell, create the YelpData database:

```
>use YelpData
```

Then create the collections for YelpData:

```
>db.createCollection('business')
>db.createCollection('checkin')
>db.createCollection('review')
>db.createCollection('user')
>db.createCollection('tip')
```



Once the database and collection is created, exit the mongo shell and open a new terminal to import the collections
```
$ mongoimport --db YelpData --collection business --file yelp_academic_dataset_business.json
$ mongoimport --db YelpData --collection business --file yelp_academic_dataset_checkin.json
$ mongoimport --db YelpData --collection business --file yelp_academic_dataset_review.json
$ mongoimport --db YelpData --collection business --file yelp_academic_dataset_user.json
$ mongoimport --db YelpData --collection business --file yelp_academic_dataset_tip.json

```


## Running the queries
All the queries are stored in the queries.sh, but they must be individually issued on the mongoshell and you must use the YelpData database.</br>
