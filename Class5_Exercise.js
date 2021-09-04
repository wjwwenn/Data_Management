// Q1: database = simpleClinic, collection = patients
use simpleClinic

// Q2: Insert the above document into the collection.
db.patients.insertOne({
    firstName: "Ben",
    lastName: "Choi",
    age: 18,
    history:[
        {disease: "cold", treatment: "pain killer"},
        {checkup: "annual", output: "OK"},
        {disease: "sore throat", treatment: "antibodies"}
        ]
    })

// Q3: Insert 3 additional patient records (documents) with at least 1 history entry per patient.
db.patients.insertMany([{
    firstName: "Jing Wen",
    lastName: "Wang",
    age: 25,
    history:[
        {disease: "cold", treatment: "pain killer"},
        ]
    },
    {
    firstName: "Max",
    lastName: "Schwarzmueller",
    age: 28,
    history:[
        {disease: "cold", treatment: "pain killer"},
        {checkup: "annual", output: "OK"},
        ]
    },
    {
    firstName: "Chris",
    lastName: "Evans",
    age: 40,
    history:[
        {disease: "cold", treatment: "pain killer"},
        {checkup: "annual", output: "OK"},
        {disease: "sore throat", treatment: "antibodies"}
        ]
    }
    ])


// Q4.	Test out your database with find()
db.patients.find({"cold":"pain killer"})

// Q5.	Find all patients who are older than 30 years old (or a value of your choice).
db.patients.find({age: {$gt: 30}})

// Q6.	Delete all patients who got a flu as a disease.
db.patients.deleteMany({disease:"flu"})
