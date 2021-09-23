use Restaurants

// 1.	Write a MongoDB query to display all the documents in the collection restaurants. 
db.restaurants.find({})

// 2.	Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine 
// for all the documents in the collection restaurant. 
db.restaurants.find({}, 
    {_id:1,  //1 to include
        name:1, 
        cuisine: 1, 
        borough: 1, 
        restaurant_id: 1})

// 3.	Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine, 
// but exclude the field _id for all the documents in the collection restaurant. 
db.restaurants.find({}, 
    {_id:0,  //0 to exclude
        name:1, 
        cuisine: 1, 
        borough: 1, 
        restaurant_id: 1})

// 4.	Write a MongoDB query to display the fields restaurant_id, name, borough and zip code, but exclude the field _id for all 
db.restaurants.find({}, 
    {_id:0, 
        name:1, 
        cuisine: 1, 
        borough: 1, 
        restaurant_id: 1,
        "address.zipcode": 1})

// 5.	Write a MongoDB query to display all the restaurant which is in the borough Bronx. 
// the documents in the collection restaurant. 
db.restaurants.aggregate([
  {$match: {borough : "Bronx"}}
])

// 6.	Write a MongoDB query to display the first 5 restaurant which is in the borough Bronx.
db.restaurants.find({"borough": "Bronx"}).limit(5)

// 7.	Write a MongoDB query to display the next 5 restaurants after skipping first 5 which are in the borough Bronx. 
db.restaurants.find({"borough": "Bronx"}).skip(5).limit(5)

// 8.	Write a MongoDB query to find the restaurants who achieved a score more than 90.
db.restaurants.find({"grades.score": {$gt : 90}})

// 9.	Write a MongoDB query to find the restaurants that achieved a score, more than 80 but less than 100. 
db.restaurants.find({$and: 
    [{"grades.score": {$gt: 90}},
     {"grades.score": {$lt: 100}}
     ]})
     
    