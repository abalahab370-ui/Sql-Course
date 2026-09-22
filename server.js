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

app.listen(3000, () => {
    console.log("Server running on http://localhost:3000");
});