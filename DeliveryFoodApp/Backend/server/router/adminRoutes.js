import express from 'express';
import { LoginAdmin } from '../controllers/loginAdmin';
import { CreateAdmin } from '../controllers/createAdmin';
import { CantidadDeVentasDiarias } from '../controllers/cantidadDeVentasDiarias';
import { Orders } from '../controllers/order';
import { productosEnStock } from '../controllers/productosEnStock';
import { deleteProduct } from '../controllers/deleteProduct';
import { ToConfirmOrder } from '../controllers/toConfirmOrder';
const adminRoutes = express.Router();

adminRoutes.post('/admin/login',LoginAdmin);

//adminRoutes.post('/admin/create',CreateAdmin);

adminRoutes.get('/totalDeVentas', CantidadDeVentasDiarias)

adminRoutes.get('/orders',Orders)

adminRoutes.get('/admin/products',productosEnStock)

adminRoutes.delete('/products/:id',deleteProduct)

adminRoutes.post('/orders/confirm',ToConfirmOrder)


module.exports = adminRoutes;