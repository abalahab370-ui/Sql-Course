// controllers/customerController.js
const { sql, poolPromise } = require('../db');

// ==========================================
// 1. GET ALL (With Pagination & Search)
// GET /api/customers?search=maria&page=1&limit=10
// ==========================================
exports.getAllCustomers = async (req, res) => {
    try {
        const { search, page = 1, limit = 10 } = req.query;
        const offset = (parseInt(page) - 1) * parseInt(limit);

        const pool = await poolPromise;
        const request = pool.request();

        let query = `
            SELECT 
                customer_id, 
                first_name, 
                last_name, 
                email, 
                join_date, 
                ISNULL(credit_score, 0) AS credit_score
            FROM customers
            WHERE 1=1
        `;

        // Dynamic Parameterized Filtering
        if (search) {
            request.input('searchTerm', sql.VarChar, `%${search}%`);
            query += ` AND (first_name LIKE @searchTerm OR last_name LIKE @searchTerm OR email LIKE @searchTerm)`;
        }

        // SQL Server Pagination (OFFSET / FETCH NEXT)
        request.input('offset', sql.Int, offset);
        request.input('limit', sql.Int, parseInt(limit));
        query += ` ORDER BY customer_id DESC OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;`;

        const result = await request.query(query);

        return res.status(200).json({
            success: true,
            page: parseInt(page),
            limit: parseInt(limit),
            resultsCount: result.recordset.length,
            data: result.recordset
        });
    } catch (err) {
        console.error('Error fetching customers:', err);
        return res.status(500).json({ success: false, message: 'Server error fetching customers' });
    }
};

// ==========================================
// 2. GET SINGLE RECORD BY ID
// GET /api/customers/:id
// ==========================================
exports.getCustomerById = async (req, res) => {
    try {
        const { id } = req.params;

        const pool = await poolPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .query(`SELECT * FROM customers WHERE customer_id = @id`);

        if (result.recordset.length === 0) {
            return res.status(404).json({ success: false, message: 'Customer not found' });
        }

        return res.status(200).json({ success: true, data: result.recordset[0] });
    } catch (err) {
        console.error('Error fetching customer by ID:', err);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};

// ==========================================
// 3. CREATE RECORD (POST)
// POST /api/customers
// ==========================================
exports.createCustomer = async (req, res) => {
    try {
        const { first_name, last_name, email, credit_score } = req.body;

        // Validation
        if (!first_name || !last_name) {
            return res.status(400).json({ success: false, message: 'First name and last name are required' });
        }

        const pool = await poolPromise;
        const result = await pool.request()
            .input('firstName', sql.VarChar(50), first_name)
            .input('lastName', sql.VarChar(50), last_name)
            .input('email', sql.VarChar(100), email || null)
            .input('score', sql.Int, credit_score || null)
            .query(`
                INSERT INTO customers (first_name, last_name, email, credit_score)
                OUTPUT INSERTED.* -- SQL Server trick: Returns the created row immediately!
                VALUES (@firstName, @lastName, @email, @score);
            `);

        return res.status(201).json({
            success: true,
            message: 'Customer created successfully',
            data: result.recordset[0]
        });
    } catch (err) {
        console.error('Error creating customer:', err);
        return res.status(500).json({ success: false, message: 'Server error creating customer' });
    }
};

// ==========================================
// 4. UPDATE RECORD (PUT/PATCH)
// PUT /api/customers/:id
// ==========================================
exports.updateCustomer = async (req, res) => {
    try {
        const { id } = req.params;
        const { first_name, last_name, email, credit_score } = req.body;

        const pool = await poolPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .input('firstName', sql.VarChar(50), first_name)
            .input('lastName', sql.VarChar(50), last_name)
            .input('email', sql.VarChar(100), email)
            .input('score', sql.Int, credit_score)
            .query(`
                UPDATE customers
                SET first_name = @firstName,
                    last_name = @lastName,
                    email = @email,
                    credit_score = @score
                OUTPUT INSERTED.*
                WHERE customer_id = @id;
            `);

        if (result.recordset.length === 0) {
            return res.status(404).json({ success: false, message: 'Customer not found or no changes made' });
        }

        return res.status(200).json({
            success: true,
            message: 'Customer updated successfully',
            data: result.recordset[0]
        });
    } catch (err) {
        console.error('Error updating customer:', err);
        return res.status(500).json({ success: false, message: 'Server error updating customer' });
    }
};

// ==========================================
// 5. DELETE RECORD (DELETE)
// DELETE /api/customers/:id
// ==========================================
exports.deleteCustomer = async (req, res) => {
    try {
        const { id } = req.params;

        const pool = await poolPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .query(`
                DELETE FROM customers 
                OUTPUT DELETED.customer_id
                WHERE customer_id = @id;
            `);

        if (result.recordset.length === 0) {
            return res.status(404).json({ success: false, message: 'Customer not found' });
        }

        return res.status(200).json({
            success: true,
            message: `Customer with ID ${id} deleted successfully`
        });
    } catch (err) {
        console.error('Error deleting customer:', err);
        return res.status(500).json({ success: false, message: 'Server error deleting customer' });
    }
};