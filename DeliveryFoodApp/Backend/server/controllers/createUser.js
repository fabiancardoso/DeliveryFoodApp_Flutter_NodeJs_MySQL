import bcrypt  from 'bcrypt';
import jwt from 'jsonwebtoken'
import {connect} from '../databases/mysqlDatabase';

export const CreateUser = async (req, res) => {
   console.log(req.body.username)
   const passwordHashed = await bcrypt.hash(req.body.password,10);
   

   const db = await connect();
   const username = req.body.username;
  

   const [query] = await db.query('SELECT * FROM clients WHERE username = ?',
   [username],
   );
    
   console.log(query.length)


   if(query.length > 0){
      return res.status(401).send()
   }
   
   
   
    await db.query('INSERT INTO clients (name, lastname,username,email,password) VALUES (?,?,?,?,?)',
   [ req.body.name,
     req.body.lastname, 
     req.body.username,
     req.body.email,
     passwordHashed
   ]
   );


   
   const [user] = await db.query('SELECT * FROM clients WHERE username = ?',
   [username],
   );
 
  
   const userForToken = {
         id: user[0].id,
         username: user[0].username,
         name: user[0].name,
       lastname: user[0].lastname,
       }

       const Token  = jwt.sign(userForToken,'cfiifcas7mert');

       res.status(201).json({
         id: user[0].id,
         name: user[0].name,
         lastname: user[0].lastname,
         username: user[0].username,
         address: user[0].address,
         imageName: user[0].imageName,
         token: Token
       })

   
}