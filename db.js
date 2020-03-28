'use strict';

var mongo = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/mydb";

mongo.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("YelpData");
    
    insertObjects(dbo,db)


    
});


/**
 * Creates collection
 */
function createCollection() {
    dbo.createCollection("businessSearch", function (err, res) {
        if (err) throw err;
        console.log("Collection created!");
        db.close();
    });
}



/**
 * inserts recieved JSON to mongodb
 * @param {database object} dbo 
 * @param {*database} db 
 */
function insertObjects(dbo,db) {

    var keys = require('./config') //api key
    let yelp = require('yelp-fusion');
    let client = yelp.client(keys.MY_KEY);
    let offsetValue = 50  //used to get next set of results from response, since maximum return is 50

    client.search({
        term: 'food',
        location: 'Montreal',
        limit: 50,
        offset: offsetValue
    }).then(response => {
        var myobj = response.jsonBody.businesses;
        console.log(myobj)

        dbo.collection("businessSearch").insertMany(myobj, function (err, res) {
            if (err) throw err;
            console.log("Number of documents inserted: " + res.insertedCount);
            db.close();
        });
    }).catch(e => {
        console.log(e);
    });




    // return result
}


