import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';

export const sendOrders = async (req,res) => {
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


        const [orders] = await db.query(
                'select * from orders where client_id = ?',
                [decodeToken.id]
        )

        let arrayOrders = []

        let i = 0;
        while(orders.length > i){
            const [product] = await db.query(
                'select * from productos where id = ?',
                [orders[i].product_id]
            )

            const [envio] = await db.query(
                'select * from envioEnCamino where order_id = ?',
                [orders[i].id]
            )
               
                let order = {
                    ProductName: product[0].name,
                    ImageName: product[0].imageName,
                    Cantidad: orders[i].cantidad,
                    MontoTotal: product[0].price*orders[i].cantidad,
                    OrderId: orders[i].id,
                    Status: envio.length > 0 ? envio[0]._status : 'A confirmar'
                }
                
                
    
                arrayOrders.push(order)
            
            
            i++;
        }
        

        
        res.json(arrayOrders)
    
}