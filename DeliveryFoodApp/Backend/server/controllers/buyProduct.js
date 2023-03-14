import jwt from 'jsonwebtoken';
import {connect} from '../databases/mysqlDatabase';


export const buyProducts = async (request,response,next) => {
    const authorization = request.get('authorization');
    const db = await connect();
    

    let token = '';

    console.log('peticion:  ',request.body.user_id)

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
        return response.status(401).json({error: 'unauthorized'})
    }
    const [client] = await db.query(
        'select * from clients where id = ?',
        [decodeToken.id]
    )


    const [producto] = await db.query(
        'select * from productos where id = ?',
        [request.body.product_id]
    )

    
    
    if((client.length > 0) & (client[0].id == decodeToken.id) & (producto.length > 0)){
        let hoy = new Date().toLocaleDateString()
        const [fecha] = await db.query(
            'select * from fechas where fecha = ?',
            [hoy]
        )

        const [address] = await db.query(
            'select * from address where address = ?',
            [request.body.address]
        )
       await db.query(
        'insert into orders(client_id,product_id,idfecha,cantidad,address_id) values(?,?,?,?,?) ',
        [client[0].id, producto[0].id,fecha[0].id,request.body.cantidad,address[0].id]
       )    
    
      


      response.status(201).send()
    }else{
        response.status(401)
        next()
    }

}