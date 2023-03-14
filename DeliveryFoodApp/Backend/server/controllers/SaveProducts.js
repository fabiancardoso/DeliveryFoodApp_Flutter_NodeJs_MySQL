import {connect} from '../databases/mysqlDatabase';
import jwt from 'jsonwebtoken';


export const SaveProducts = async (req, res) => {
    
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
   
    const [category] = await db.query(
        'select * from category where name = ?',
        [req.body.category]
     )

     if(category.length > 0){
   
        await db.query(
            'insert into productos(name,price,imageName,category) values(?,?,?,?)',
            [req.body.name,req.body.price,req.file.filename,category[0].id]
        )
    
     }
    
    res.send().status(201);
   
}    

 