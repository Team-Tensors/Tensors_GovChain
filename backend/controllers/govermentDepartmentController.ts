// backend/src/controllers/departmentController.ts
import { Request, Response } from 'express';
import * as departmentService from '../services/govermentDepartmentsService';

export const listDepartments = async (req: Request, res: Response) => {
  try {
    const departments = await departmentService.getDepartments();
    res.status(200).json(departments);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch departments' });
  }
};

export const getServices = async (req: Request, res: Response) => {
  const departmentId = parseInt(req.params.id);
  try {
    const services = await departmentService.getServicesByDepartment(departmentId);
    res.status(200).json(services);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch services for the department' });
  }
};