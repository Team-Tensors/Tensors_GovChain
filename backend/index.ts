import express, { Request, Response } from "express";
import cors from "cors";
import { PrismaClient } from '@prisma/client';
import govermentDepartmentRoutes from './routes/govermentDepartmentRoutes';

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT ? Number(process.env.PORT) : 5000;

app.use('/api/departments', govermentDepartmentRoutes);

const prisma = new PrismaClient();

// Start server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`✅ Server running on http://localhost:5001`);
});
