import {connect} from '../databases/mysqlDatabase';
import jwt from  'jsonwebtoken';

export const updatePrice = async (req,res) => {
        
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
         
        await db.query(
                'update productos set price = ? where id = ?',
                [req.body.price,req.body.id]
        )
        
    if (req.body.offer != 'Sin oferta') {
        const [sale] = await db.query(
            'select * from sales where product_id = ?',
            [req.body.id]
        )

        const [offer] = await db.query(
            'select * from offers where name = ? ',
            [req.body.offer]
        )

        if (sale.length > 0) {
            

            if (offer.length > 0) {
                await db.query(
                    'update sales set offerId = ?,descuento = ? where product_id = ?',
                    [offer[0].id, req.body.porcentaje,req.body.id]
                )
            }
        }else{
            if (offer.length > 0) {
                await db.query(
                    'insert into sales(offerId,descuento,product_id) values(?,?,?)',
                    [offer[0].id, req.body.porcentaje,req.body.id]
                )
            }
        }
    }
       
     res.status(201).send()
        

      
    
}
