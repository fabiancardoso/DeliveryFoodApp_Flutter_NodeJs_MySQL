import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';


export const ToConfirmOrder = async (req, res) => {
    
    const authorization = req.get('authorization');
    
    let token = '';

    

    if(authorization && authorization.toLowerCase().startsWith('bearer')){
        token = authorization.substring(7)
    }
    let decodeToken = {};

    
    if(token.length > 0){ 
        decodeToken = jwt.verify(token, 'cfiifcas7mert')
    }else{
        return res.status(401)
    }    

    if(!token || !decodeToken.id){
        return res.status(401).json({error: 'unauthorized'})
    }
   

   const db = await connect()
    
    const [order] =  await db.query(
        'select * from orders where id = ?',
        [req.body.orderId]
    )

    if (order.length > 0) {

        const [verify] = await db.query(
            'select * from envioEnCamino where order_id = ? ',
            [order[0].id]
        )

        if(verify.length == 0){
            await db.query(
                'insert into envioEnCamino(order_id,_status) values(?,?)',
                [order[0].id,'En camino']
            )
        }

    }else{
       return res.status(403).send()
    }
    
    res.status(200).send()
   
   
}    

 