const bcrypt = require('bcrypt');
import jwt from 'jsonwebtoken';
import {connect} from '../databases/mysqlDatabase';

export const ChangeData = async (req,res) => {
    const authorization = req.get('authorization');

    let token = '';

    

    if (authorization && authorization.toLowerCase().startsWith('bearer')) {
        token = authorization.substring(7)
    }
    let decodeToken = {};
    

    if(token.length > 0){ 
        decodeToken = jwt.verify(token, 'cfiifcas7mert')
    }else{
        return res.status(401)
    }    

    if (!token || !decodeToken.id) {
        return res.status(401).json({ error: 'unauthorized' })
    }
       
        const db = await connect();
        const [user] = await db.query('select * from clients where name = ?',
        [decodeToken.name]
        ) 
        if (user.length == 0) {
            return res.status(403).send();
        }else{
            const typeData = req.body.typeData
            const typeDataLowerCase = typeData.toLowerCase()
            if(typeDataLowerCase != 'password'){
            
                if(typeDataLowerCase == 'name'){
                    db.query(
                        'update clients set name = ? where name = ?',
                        [req.body.data,decodeToken.name]
                    )
                }
                if(typeDataLowerCase == 'lastname'){
                    db.query(
                        'update clients set lastname = ? where name = ?',
                        [req.body.data,decodeToken.name]
                    )
                }

                if(typeDataLowerCase == 'email'){
                    db.query(
                        'update clients set email = ? where name = ?',
                        [req.body.data,decodeToken.name]
                    )
                }

                if(typeDataLowerCase == 'username'){
                    db.query(
                        'update clients set username = ? where name = ?',
                        [req.body.data,decodeToken.name]
                    )
                }

                

            

           
      
             res.status(201).send()
             

             console.log('hola mundo')
            }
            
        }
        


        
       
}