import express from 'express';
import { LoginUser } from '../controllers/login';
import { CreateUser } from '../controllers/createUser';
import {visitedProduct } from '../controllers/visitedProduct';
import { ProductosvistosUltimamente } from '../controllers/ProductosVistosUltimamente';
import { ProductosMasvistos } from '../controllers/productosMasVistos';
import { ChangePassowrd } from '../controllers/changePassword';
import { ChangeData } from '../controllers/changeData';
import { saveProfilePicture } from '../controllers/saveProfilePicture';
import { SaveAddress } from '../controllers/saveAddress';
import { GetAddress } from '../controllers/getAddress';
import { DeleteAddress } from '../controllers/deleteAddress';
import { sendOrders } from '../controllers/sendOrders';
import { confirmDelivery } from '../controllers/confirmDelivery';

const UserRoutes = express.Router();

UserRoutes.post('/users/login',LoginUser);

UserRoutes.post('/users/create',CreateUser);

UserRoutes.post('/users/productVisited',visitedProduct)

UserRoutes.get('/users/productosUltimamenteVistos', ProductosvistosUltimamente)

UserRoutes.get('/users/productosMasVistos', ProductosMasvistos)

UserRoutes.put('/users/password',ChangePassowrd)

UserRoutes.put('/users/',ChangeData)

UserRoutes.post('/users/picture',saveProfilePicture)

UserRoutes.post('/users/address',SaveAddress)

UserRoutes.get('/users/address',GetAddress)

UserRoutes.delete('/users/address',DeleteAddress)

UserRoutes.post('/users/order',confirmDelivery)

UserRoutes.get('/users/orders',sendOrders)

module.exports = UserRoutes;