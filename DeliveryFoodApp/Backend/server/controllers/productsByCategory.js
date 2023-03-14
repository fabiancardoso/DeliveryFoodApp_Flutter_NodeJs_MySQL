import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';

export const productsByCategory = async (req, res) => {

    const authorization = req.get('authorization');

    let token = '';



    if (authorization && authorization.toLowerCase().startsWith('bearer')) {
        token = authorization.substring(7)
    }
    let decodeToken = {};


    if (token.length > 0) {
        decodeToken = jwt.verify(token, 'cfiifcas7mert')
    } else {
        return res.status(401)
    }
    if (!token || !decodeToken.id) {
        return res.status(401).json({ error: 'unauthorized' })
    }

    const db = await connect()

    const [category] = await db.query(
        'select * from category where name = ?',
        [req.body.category]
    )


    

    let arrayProducts = []

    const [products] = await db.query(
        'select * from productos where category = ?',
        [category[0].id]
    )
    
   
    

    let i = 0
    while (products.length > i) {
        let _products = {
            id: null,
            name: null,
            price: null,
            imageName: null,
            offerType: null,
            descuento: null,
        }
        const [sales] = await db.query(
            'select * from sales where product_id = ?',
            [products[i].id]
        )
        
        if(sales.length > 0) {
        const [offerType] = await db.query(
            'select * from offers where id = ?',
            [sales[i].offerId]
        )
        
        if (offerType[0].name == 'Porcentaje de descuento') {
            _products.price = (products[i].price * sales[0].descuento) / 100
            _products.descuento = sales[i].descuento
        } else {
           _products.price = products[i].price
        }
        _products.offerType = offerType[0].name
        }else{
           _products.price = products[i].price
        }
       
        _products.id = products[i].id
        _products.name = products[i].name
        _products.imageName = products[i].imageName
        arrayProducts.push(_products);
        i++;
    }
    

    res.json(arrayProducts)

}