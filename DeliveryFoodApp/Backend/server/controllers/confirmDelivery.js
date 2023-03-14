import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';

export const confirmDelivery = async (req,res) => {
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

        const [order] = await db.query(
            'select * from orders where id = ? and client_id = ?',
            [req.body.order,decodeToken.id]
        )
        
        if(order.length > 0) {
            await db.query(
              'update envioEnCamino set _status = ? where order_id = ?',
              ['Delivered product',order[0].id]
            )
        }else{
            return res.status(401).json({ error: 'unauthorized' })
        }
    res.status(200).send()
}