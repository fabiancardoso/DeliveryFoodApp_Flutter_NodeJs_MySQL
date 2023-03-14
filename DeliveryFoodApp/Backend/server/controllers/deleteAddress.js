import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';


export const DeleteAddress = async (req, res) => {
    
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
        'delete from address where address = ? and client_id = ?',
        [req.body.address,decodeToken.id]
    )

    
    
    
    res.send().status(200);
   
}    