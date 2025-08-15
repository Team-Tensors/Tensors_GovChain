// backend/src/routes/departmentRoutes.ts
import { Router } from 'express';
import { listDepartments, getServices } from '../controllers/govermentDepartmentController';

const router = Router();

router.get('/', listDepartments);
router.get('/:id/services', getServices);

export default router;