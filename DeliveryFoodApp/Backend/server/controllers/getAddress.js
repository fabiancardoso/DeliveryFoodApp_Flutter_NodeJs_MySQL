import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';


export const GetAddress = async (req, res) => {
    
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
   
    const [address] = await db.query(
        'select * from address where client_id = ?',
        [decodeToken.id]
    )

    if (address.length > 0) {

        
        res.json(address).status(200);

    }else{
        return res.status(401).send()
    }
    
    
   
   
}    

 