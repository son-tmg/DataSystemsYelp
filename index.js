'use strict';


//------------------------------ CHANGE THE VALUE DAILY FROM YESTERDAY ---------------------
//------------------ SET offsetValue TO YESTERDAYS db.businessSearch.find().size()

let offsetValue = 0  //used to get next set of results from response, since maximum return is 50

//------------------------------ CHANGE THE VALUE DAILY FROM YESTERDAY ---------------------


var keys = require('./config') //api key
let yelp = require('yelp-fusion');
let client = yelp.client(keys.MY_KEY);
var results = []

var mongo = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/mydb";


function searchYelp() {
  client.search({
    location: 'Montreal',
    limit: 50,
    offset: offsetValue
  }).then(response => {
    results.push(response.jsonBody.businesses)
    // console.log("DEBUG: " + offsetValue)
    offsetValue += 50

    if (offsetValue == 100) {
      // console.log("DEBUG: " + offsetValue)
      clearInterval(timeoutObj)
      results.forEach(element => insertObjectsToDB(element));
      
    }

  }).catch(e => {
    console.log(e);
  });

}


function insertObjectsToDB(myobj) {
  mongo.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("YelpData");

    dbo.collection("businessSearch").insertMany(myobj, function (err, res) {
      if (err) throw err;
      console.log("Number of documents inserted: " + res.insertedCount);
      db.close();
    });
  });
}


//run methods below


const timeoutObj = setInterval(searchYelp, 5000);



