#query 1 : number of distinct cities referred in the dataset


db.business.distinct('city').length

#we created a single key index on "city" column

db.business.createIndex(city:1)






#query 2 : Determine the number of businessers per city, in acending order of city

db.business.aggregate(
    {
        $sort:{city:1}
    }
    ,{
        $group : {
            _id:"$city", 
            count: {$sum:1}
        }
    }
)







#query 3 : Order the cities by average star rating

db.business.aggregate(
    {
        $group : {
            _id:"$city",
            count: {$sum:1},
            review:{$avg:"$stars"}
        }
    },
    {
        $sort:{review:-1}
    }
)



#query 4 : Determine the cities with the most amount of reviews, sorted in descending review count


db.business.aggregate(
    {
        $group : {
            _id:"$city",
            reviewCount: {$sum:"$review_count"}
            }
    },
    {
        $sort:{reviewCount:-1}
    }
)




#query 5 : Comapre the Yelper with the most fans and the most helpful (tips)

#Yelper with the most fans
    #1) find the user_id with the highest number of fans
    #2) find the total_compliment_count for that user

db.user.find({},{_id:0,user_id:1,name:1,fans:1}).sort({fans:-1}).limit(1).pretty()

db.tip.aggregate(
    {
        $match: {user_id:'37cpUoM8hlkSQfReIEBd-Q'}
    },
    {
        $group : {
            _id:"$user_id",
            total_compliment_count:{$sum:"$compliment_count"},
        }
    },
    {
        $sort:{total_compliment_count:-1}
    },
    {
        $limit:1
    }
)



#The most helpful yelper (most compliments on tips)
    #1) sort the sum of total_compliment_count, then find the id.
    #2) use the id to fgind the number of fans
db.tip.aggregate(
    {
        $group : {
            _id:"$user_id",
            total_compliment_count:{$sum:"$compliment_count"},
        }
    },
    {
        $sort:{total_compliment_count:-1}
    },
    {
        $limit:1
    }
)

#result shows 'mkbx55W8B8aPLgDqex7qgg'. Use it to find the number of fans
db.user.find({'user_id':'mkbx55W8B8aPLgDqex7qgg'},{_id:0,user_id:1,name:1,fans:1}).pretty()







#query 6 : Determine the number of businesses in Montreal.

db.business.find({'city':{$regex : /^(M|m)ontr(e|é|è)al.*/ }}).size()






#query 7 : Determine the cities with the most amount of variety (most amount of distinct business categories)

db.business.aggregate([
    {
        $group:{
            _id:"$city",
            numberOfCategories: {$sum: {$size: {$ifNull: [{$split:["$categories",","]}, [0] ]}  }}
        }
    },
    {
        $sort:{numberOfCategories:-1}
    }
])



#query 8 : Compare the oldest Yelper to the Yelper with the most review count


#find the oldest yelper first
db.user.aggregate([
    {
    $project:{
            _id:0,
            username:"$name",
            yelpingSince: {
                $dateFromString:{dateString:'$yelping_since'}
            },
            review_count: "$review_count"
        }
    },
    {
        $sort:{yelpingSince:1}
    },
    {
        $limit:1
    }
])



#find yelper witht he most review count

db.user.find({},{_id:0,name:1,review_count:1, yelping_since:1}).sort({review_count:-1}).limit(1)







#query 9 : Determine the business with the most check ins (check-ins: when a Yelper visits a business)

#get ID of most checkin count frpm checkin collection

db.checkin.aggregate([
    {
        $group : {
            _id:"$business_id",
            count: {$sum: {$size: {$ifNull: [{$split:["$date",","]}, [0] ]}  }}
        }
    },
    {
        $sort:{count:-1}
    },
    {
        $limit:1
    }
])


#use ID of most checkin count (from checkin collection) and use it in the business collection

db.business.find({business_id:'FaHADZARwnY4yvlvpnsfGA'}).pretty()





#query 10 : Find the businesses that are the closest to concordia, sorted by rating (closest in our case means same 3 first postal code characters)

db.business.find({'postal_code':{$regex : /(H3G)\s(?!1M8)([0-9][A-Z][0-9])/ }},{_id:0,name:1,address:1,postal_code:1,stars:1, review_count:1}).sort({stars:-1}).pretty()

