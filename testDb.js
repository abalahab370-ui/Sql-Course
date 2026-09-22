require('dotenv').config();

const sql = require('mssql');

const config = {
    user: 'sa',
    password: 'YourStrongPassword123!',
    server: 'localhost',
    database: 'Sales.db',

    options: {
        encrypt: false,
        trustServerCertificate: true
    }
};

// Create the connection pool
const poolPromise = sql.connect(config);


module.exports = { sql, poolPromise };