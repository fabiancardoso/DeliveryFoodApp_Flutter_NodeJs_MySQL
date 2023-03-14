import {connect} from '../databases/mysqlDatabase';
import jwt from  'jsonwebtoken';

export const visitedProduct = async (req,res) => {
        
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

        const today = new Date().toLocaleDateString()
        
        let [fecha] = await db.query(
            'select * from fechas where fecha = ?',
            [today]
        )

        if(fecha.length === 0){
           await db.query(
              'insert into fechas (fecha) values (?)',
              [today]
           )

           const [newFecha] = await db.query(
            'select * from fechas where fecha = ? order by id desc limit 1',
            [today]

            )

            fecha = newFecha
        }

        const fechaYhora = new Date().toLocaleString()
        

        
         
        const [product] = await db.query(
                'select * from productos where id = ?',
                [req.body.product_id]
        )
        
    if(product.length > 0){
       
        let [productoVisitado] = await db.query(
            'select cantidad from productos_mas_vistos where client_id = ? and product_id = ?',
            [decodeToken.id, product[0].id]
        )
        
        if(productoVisitado.length > 0){
            let cantidad = productoVisitado[0].cantidad

            cantidad++

            await db.query(
                'update productos_mas_vistos set cantidad = ? where client_id = ? and product_id = ?',
                [cantidad,decodeToken.id,product[0].id]
            )
        }else{
            await db.query(
                'insert into productos_mas_vistos(cantidad,client_id,product_id) values(?,?,?)',
                [1,decodeToken.id,product[0].id]
            )
        }

        const [productoVisto] = await db.query(
            'select * from productos_ultimamente_vistos where client_id = ? and product_id = ?',
            [decodeToken.id,product[0].id]
        )

        if(productoVisto.length == 0){
            await db.query(
                'insert into productos_ultimamente_vistos(client_id,product_id,fecha) values(?,?,?)',
                [decodeToken.id,product[0].id,fechaYhora]
            )
        }else{
            await db.query(
                'update productos_ultimamente_vistos set fecha = ? where client_id = ? and product_id = ?',
                [fechaYhora,decodeToken.id,product[0].id]
            )
        }



    }else{
        res.status(401).send()
    }
    
       
     res.status(200).send()
        
    
      
    
}