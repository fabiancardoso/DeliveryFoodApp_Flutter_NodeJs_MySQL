import bcrypt  from 'bcrypt';
import {connect} from '../databases/mysqlDatabase';

export const CreateAdmin = async (req, res) => {
   console.log(req.body.username)
   const passwordHashed = await bcrypt.hash(req.body.password,12);
   

   const db = await connect();
   
    
   
   
   await db.query('INSERT INTO admin (name, lastname,username,email,password) VALUES (?,?,?,?,?)',
   [ req.body.name,
     req.body.lastname, 
     req.body.username,
     req.body.email,
     passwordHashed
   ]
   );

   

   const [admin] = await db.query(
      'SELECT * FROM admin WHERE username = ?',
       [req.body.username]
      );
 
  
   const userForToken = {
          id: admin[0].id,
          name: admin[0].name,
          lastname: admin[0].lastname,
          username: admin[0].username
       }

       const Token  = jwt.sign(userForToken,'cfiifcas7mert');

       res.status(200).json({
          name: admin[0].name,
          lastname: admin[0].lastname,
          username: admin[0].username,
          token: Token
       })

       

   
}