// backend/src/services/departmentService.ts
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const getDepartments = async () => {
  return prisma.governmentDepartment.findMany({
    include: { Service: true },
  });
};

export const getServicesByDepartment = async (departmentId: number) => {
  return prisma.service.findMany({
    where: { department_id: departmentId },
  });
};