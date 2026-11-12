import express from 'express';
import { getHomePage } from './controllers/homeController.js';
import { getOrganizationsPage } from './controllers/organizationController.js';
import { getProjectsPage } from './controllers/projectController.js';
import { getCategoriesPage } from './controllers/categoryController.js';

const router = express.Router();

router.get('/', getHomePage);
router.get('/organizations', getOrganizationsPage);
router.get('/projects', getProjectsPage);
router.get('/categories', getCategoriesPage);

export default router;