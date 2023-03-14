import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';

export const sales = async (req, res) => {

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

    const [sales] = await db.query(
        'select * from sales'
    )


    let products = {
        id: null,
        name: null,
        price: null,
        imageName: null,
        offerType: null,
        descuento: null,
    }

    let arrayProducts = []

    let i = 0
    while (sales.length > i) {
        const [product] = await db.query(
            'select * from productos where id = ?',
            [sales[i].product_id]
        )
        
        const [offerType] = await db.query(
            'select * from offers where id = ?',
            [sales[i].offerId]
        )
        products.id = product[0].id
        products.name = product[0].name
        if (offerType[0].name == 'Porcentaje de descuento') {
            products.price = (product[0].price * sales[i].descuento) / 100
            products.descuento = sales[i].descuento
        } else {
           products.price = products[0].price
        }
        products.imageName = product[0].imageName
        products.offerType = offerType[i].name
        arrayProducts.push(products);
        i++;
    }
    

    
    res.json(arrayProducts)

}