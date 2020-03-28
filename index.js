'use strict';

var keys = require('./config') //api key
let yelp = require('yelp-fusion');
let client = yelp.client(keys.MY_KEY);
let offsetValue = 50  //used to get next set of results from response, since maximum return is 50
let result = {}


  client.search({
    term: 'food',
    location: 'Montreal',
    limit: 50,
    offset: offsetValue
  }).then(response => {
    result = [response.jsonBody.businesses]
    console.log(typeof(result))
  }).catch(e => {
    console.log(e);
  });


