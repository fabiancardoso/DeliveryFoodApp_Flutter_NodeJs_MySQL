import express from 'express';
import {findProducts}from '../controllers/findProducts';
import {SaveProducts} from '../controllers/SaveProducts';
import {buyProducts} from '../controllers/buyProduct';
import {updatePrice} from '../controllers/updateProduct';
import {sales} from '../controllers/sales';
import { productsByCategory } from '../controllers/productsByCategory';

const ProductsRoute = express.Router();

ProductsRoute.post('/products/search', findProducts)

ProductsRoute.get('/products/sales',sales)

ProductsRoute.post('/products',SaveProducts)

ProductsRoute.get('/images/:name',(req,res) => {
    const name = req.params.name;
    console.log(name)
    res.sendFile('public/img/uploads/'+name)
})

ProductsRoute.post('/products/buy',buyProducts)

ProductsRoute.put('/products/',updatePrice)

ProductsRoute.post('/products/category',productsByCategory)


module.exports = ProductsRoute;