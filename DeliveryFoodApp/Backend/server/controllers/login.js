const bcrypt = require('bcrypt');
import jwt from 'jsonwebtoken';
import {connect} from '../databases/mysqlDatabase';

export const LoginUser = async (req,res) => {
    
        const Email = req.body.email;
        const password = req.body.password;
        const db = await connect();
        const [user] = await db.query('select * from clients where email = ?',
        [Email]
        ) 
        if (user.length == 0) {
            return res.status(403).send();
        }else{
           const passwordCorrect = await bcrypt.compare(password,user[0].password);
           if(!(passwordCorrect)){
             res.status(403).json({ message: 'Incorrect user or password'});
           }else{
             const userForToken = {
                id: user[0].id,
                username: user[0].username,
                name: user[0].name,
                lastname: user[0].lastname,
             }

             const Token  = jwt.sign(userForToken,'cfiifcas7mert');

             res.status(200).json({
                id: user[0].id,
                name: user[0].name,
                lastname: user[0].lastname,
                username: user[0].username,
                imageName: user[0].imageName,
                token: Token
             }).send()
            
           }

        }
       
}