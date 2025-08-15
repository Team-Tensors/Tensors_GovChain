import express, { Request, Response } from "express";
import cors from "cors";
import { Pool } from "pg";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT ? Number(process.env.PORT) : 5000;

// Create PostgreSQL pool
const pool = new Pool({
  connectionString: process.env.PG_CONNECTION_STRING,
});

// Example route to fetch records from a table
app.get("/api/mock-records", async (req: Request, res: Response) => {
  try {
    const result = await pool.query("SELECT * FROM mock_table"); // replace table name
    res.json({ records: result.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database query failed" });
  }
});

// Start server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`✅ Server running on http://localhost:5001`);
});
