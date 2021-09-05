use boxoffice

// see what is in the database
db.getCollection('moviestarts').find({})

// 1.	Display the first document
db.getCollection('moviestarts')
        .find({})
        .limit(1)
        .sort({id: 1})
        // Documentation: toArray() method returns an array that contains all the documents from a cursor.
        .toArray()
        
// 2.	Search all movies that have a rating higher than 9.2 and a runtime lower than 100 minutes
db.getCollection('moviestarts').find(
    {$and: [
        {rating: {$gte: 9.2}},
        {runtime: {$lt: 100}}
    ]
}
)

// 3.	Search all movies that have a genre of “drama” or “action”. 
db.getCollection('moviestarts').find(
    {$and: [
        {genre: "drama"},
        {genre: "action"}
    ]
}
)

// 4.	Search all movies that have a genre of “drama” and “action”. You must not use $and.
db.getCollection('moviestarts').aggregate([{$match: {genre: {$in: [ 'drama' ,'action' ] }} }]);
        
// 5.	Search all movies where visitors exceeded expected visitors
db.getCollection('moviestarts').find({
        $expr: {gt:["$visitors", "$expectedVisitors"]}
    })
        
// 6.	Search all movies that have a title contains the letter “Su”.
db.getCollection('moviestarts').find({title: {$regex: "Su"}})
    
// 7.	Search all movies that either have a genre of “action” and “thriller” or have a genre of “drama”, 
//      and at the same time, have more than 300000 visitors with a rating between 8 and 9.5 (inclusive).

db.getCollection('moviestarts').aggregate([
     { $match: { $or: [{ 
         $and: [{genre: 'action'}, {genre: 'thriller' }, 
         {visitors: {$gt: 30000}},
         {rating: {$lte: 9.5}},
         {rating: {$gt: 8}}
         ]}, 
         { genre: 'thriller' }] }
     },
 ])