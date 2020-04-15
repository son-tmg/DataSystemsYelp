#create mongodb database 
mongo
use YelpData


#create collections
db.createCollection('business')
db.createCollection('checkin')
db.createCollection('review')
db.createCollection('user')
db.createCollection('tip')


#script to load json into collections of YelpData database
mongoimport --db YelpData --collection business --file data/yelp_academic_dataset_business.json
mongoimport --db YelpData --collection business --file data/yelp_academic_dataset_checkin.json
mongoimport --db YelpData --collection business --file data/yelp_academic_dataset_review.json
mongoimport --db YelpData --collection business --file data/yelp_academic_dataset_user.json
mongoimport --db YelpData --collection business --file data/yelp_academic_dataset_tip.json
