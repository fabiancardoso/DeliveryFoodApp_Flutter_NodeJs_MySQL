import {connect} from '../databases/mysqlDatabase'
import jwt from 'jsonwebtoken';


export const ProductosvistosUltimamente = async (req,res) => {
    const authorization = req.get('Authorization');
    
    let token = '';

    

    if(authorization && authorization.toLowerCase().startsWith('bearer')){
        token = authorization.substring(7)
    }
    let decodeToken = {};
    
    
    if(token.length > 0 && token != null){ 
        decodeToken = jwt.verify(token, 'cfiifcas7mert')
    }else{
        return res.status(401)
    }    

    if(!token || !decodeToken.id){
        return res.status(401).json({error: 'unauthorized'})
    }

       
    const db = await connect()

    const [productosVistos] = await db.query(
        'select * from productos_ultimamente_vistos where client_id = ? order by fecha desc',
        [decodeToken.id,]
    )
    
    let productos = []

    
   

    let i = 0
    
    while(productosVistos.length > i){
        const [producto] = await db.query(
           'select * from productos where id = ?',
           [productosVistos[i].product_id]   
        )
       
        const [sale] = await db.query(
            'select * from sales where product_id = ?',
           [producto[0].id]
        )

        let products = {
            id: null,
            name: null,
            price: null,
            imageName: null,
            offerType: null,
            descuento: null,
        }

        if (sale.length > 0 && (sale[0].product_id == producto[0].id)) {

            const [offerType] = await db.query(
                'select * from offers where id = ?',
                [sale[0].offerId]
            )

            products.id = producto[0].id
            products.name = producto[0].name
            if (offerType[0].name == 'Porcentaje de descuento') {
                products.price = (producto[0].price * sale[0].descuento) / 100
            } else {
                products.price = producto[0].price
            }
            products.imageName = producto[0].imageName
            products.offerType = offerType[0].name
            products.descuento = sale[0].descuento
        }else{
            products.id = producto[0].id
            products.name = producto[0].name
            products.price = producto[0].price
            products.imageName = producto[0].imageName
            products.offerType = null
            
        }

       

       productos.push(products);
       i++;
   }

  
  
   res.json(productos)    
};