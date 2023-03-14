import mongoose from 'mongoose';
import mysql from 'mysql2/promise';

(async () =>{
     const db = await mongoose.connect('mongodb://localhost/productos',{
          useNewUrlParser: true,
          useUnifiedTopology: true
          
     })
     console.log('database is connected to: ',db.connection.name)
      

})();

