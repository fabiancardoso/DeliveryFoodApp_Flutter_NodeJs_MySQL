import {connect} from '../databases/mysqlDatabase';
import jwt from  'jsonwebtoken';

export const deleteProduct = async (req,res) => {
        
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
         
        const [producto] = await db.query(
                'select * from productos where id = ?',
                [req.params.id]
        )

        if(producto.length > 0){
            await db.query(
                'delete from productos where id = ?',
                [req.params.id]
            )
        }else{
            return res.status(404)
        }
        
    
       
     res.status(200).send()
        

      
    
}