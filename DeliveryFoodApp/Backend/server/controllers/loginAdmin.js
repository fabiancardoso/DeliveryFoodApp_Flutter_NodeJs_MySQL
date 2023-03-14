const bcrypt = require('bcrypt');
import jwt from 'jsonwebtoken';
import {connect} from '../databases/mysqlDatabase';

export const LoginAdmin = async (req,res) => {
    
        const Email = req.body.email;
        const password = req.body.password;
        const db = await connect();
        const [admin] = await db.query('select * from admin where email = ?',
        [Email]
        ) 
        if (admin.length == 0) {
            return res.send().status(403);
        }else{
           const passwordCorrect = await bcrypt.compare(password,admin[0].password);
           if(!(passwordCorrect)){
             res.status(403).json({ message: 'Incorrect user or password'});
           }else{
             const userForToken = {
                id: admin[0].id,
                username: admin[0].username,
                name: admin[0].name,
                lastname: admin[0].lastname
             }

             const Token  = jwt.sign(userForToken,'cfiifcas7mert');

             res.status(200).json({
                id: admin[0].id,
                name: admin[0].name,
                lastname: admin[0].lastname,
                username: admin[0].username,
                token: Token
             })
             
           }

        }
       
}