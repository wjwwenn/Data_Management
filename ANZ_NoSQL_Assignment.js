use anz

// 1)	How many transactions are performed by each customer_id? 
db.anz.aggregate([
   {
      $setWindowFields: { //MongoDB 5.0
         partitionBy: "$SumAmountForState",
         sortBy: {transactions: -1}, //sort by descending
         output: {
            transactions: {
                $sum:"$transaction_id", //sum no. of transactions
                window: {
                  documents: ["unbounded", "current"]       
               }
            },
            }
         }
   },
   {   $group: {
        _id:{customer_id: "$customer_id"},
        transactions:{$sum:1},        
   }}
])
                
// 2)	Which state has customers with the highest average transaction amount?
// Answer: State of ACT has customers with the highest average transaction amount
db.anz.aggregate([
      {$group:{_id:{groupByState:"$merchant_state"}, 
          averageTrans:{$avg:"$amount"}}},
      {$sort:{averageTrans:-1}}])
      
// 3)	Monthly transaction insights – for each month, generate the number of transactions made in each merchant_state.
db.anz.aggregate([
    {$project:
        {
        date:{$convert: {input: "$date", to: "date" }}, //from string to date
        "merchant_state":1,
        "numTransactionsPerMonth":1}
    },
    {$group:{
        _id:{month:{$month: "$date"}, merchant_state: "$merchant_state"}, //from date to month
        merchant_state:{$first: "$merchant_state"}, //display top transaction + month for each state
        numTransactionsPerMonth:{$sum:1}}},
    {$sort:{merchant_state:-1}}
])

// 4)	Demographic and locational insights – For each merchant_state, generate the amount of unique male customers and female customers.
db.anz.aggregate([
  {$project: {
    male: {$cond: [{$eq: ["$gender", "M"]}, 1, 0]}, //segregation to gender using $cond, if then else
    female: {$cond: [{$eq: ["$gender", "F"]}, 1, 0]},
    merchant_state: "$merchant_state"
  }},
  {$group: {
        _id:{merchant_state: "$merchant_state"},
        male_customers: {$sum: "$male"},
        female_customers: {$sum: "$female"},
        total: {$sum: 1}, //check: sum gender per state
  }},
])
