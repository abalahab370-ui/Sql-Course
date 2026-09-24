//So basiclly i want to make a req to the data base in order to do a data manipulation ! 

//since we are not aiming to build a big api , we gonna just make a single rout and try to hit it with post man or what ever u want in local host !
require("dotenv").config();

const { sql, poolPromise } = require("./testDb");
const express = require("express");
const app = express();

app.use(express.json());

app.post("/api/registCustomer", async (req, res) => {

    try {

        const { first_name, last_name } = req.body;

        // Open/get the database connection
        const pool = await poolPromise;

        // Create a request
        const request = pool.request();

        // Check input
        if (!first_name || !last_name) {
            return res.status(400).json({
                message: "first_name and last_name are required"
            });
        }

        // Attach parameters
        request.input("first_name", sql.VarChar, first_name);
        request.input("last_name", sql.VarChar, last_name);

        // Execute query
        const result = await request.query(`
            INSERT INTO customers (first_name, last_name)
            VALUES (@first_name, @last_name) ;
        `);

        // Send response
        res.json({
            message: "Customer registered successfully",
            result: result
        });

    } catch (err) {

        console.error(err);

        res.status(500).json({
            message: "Database error",
            error: err.message
        });

    }
});


app.get('/api/orders/top-per-customer' , async (req , res) => {
    try {

        const {top} = req.query ;

        if (!top) {
            return res.status(400).json({'message' : 'mate i can give like top one or something like that but i dont really have energy for that'}) ;
        } ;
        //buddy we have to deal with that type shi of connectio to sql database first )=) :
        const pool = await poolPromise;

        const request = pool.request() ;
        
        request.input('rowLimit',sql.Int , top) ;

        const result = await request.query(`
        SELECT DISTINCT
        * ,
        max(row_num) over() as rowLimit
        from (
        SELECT [order_id]
            ,[customer_id]
            ,[order_date]
            ,[total_amount]
            ,[status],
            ROW_NUMBER() over(PARTITION BY customer_id order by total_amount DESC) AS  row_num ,
            rank() over(PARTITION BY customer_id order by total_amount DESC) AS  
            rk ,
            dense_rank() over(PARTITION BY customer_id order by total_amount DESC) AS  dense_rk,
            SUM(total_amount) over(PARTITION BY customer_id order by order_date) as running_total,
            AVG(isnull(cast(total_amount as int),0)) over(PARTITION BY customer_id ) as avg_order_amount 
        from orders
        )t 
        where 
        row_num <= @rowLimit ;
        `) ;
        return res.status(200).json(result.recordset)
    }catch (err){
        console.error(`Sir we have a problem in getting top N per Customer ! : ${err}`);
    }
})



app.listen(3000, () => {
    console.log("Server running on http://localhost:3000");
});