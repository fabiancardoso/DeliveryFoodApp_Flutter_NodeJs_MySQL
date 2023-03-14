import {connect} from '../databases/mysqlDatabase';
import jwt from  'jsonwebtoken';



export const Orders = async (req, res) => {

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
     

    const db = await connect()

    let today = new Date().toLocaleDateString()
   
    const [fechaVerify] = await db.query(
        'select * from fechas where fecha = ?',
        [today]
    )

    if(fechaVerify.length == 0){
        await db.query(
            'insert into fechas(fecha) values(?)',
            [today]
        )
       
    }

   const [fecha] = await db.query(
        'select * from fechas where fecha = ?',
        [today]
    )

    const [orders] = await db.query(
        'select * from orders where idFecha = ? ',
        [fecha[0].id]
    )

   

    let resJson = [];
    let i = 0;
    while(orders.length > i) {
        const [producto] = await db.query(
            'select * from productos where id = ?',
            [orders[i].product_id]
        );

        const [client] = await db.query(
            'select * from clients where id = ?',
            [orders[i].client_id]
        );

        const [address] = await db.query(
            'select * from address where id = ?',
            [orders[i].address_id]
        )

        const [envio] = await db.query(
          'select * from envioEnCamino where order_id = ?',
          [orders[i].id]
            )
        
            const Json = {
                id: orders[i].id,
                address: address[0].address,
                imageName: producto[0].imageName,
                client: client[0].name,
                amount: orders[i].cantidad,
                price: producto[0].price,
                status: envio.length > 0? envio[0]._status : '',
            }

            resJson.push(Json)
        

        
        i++
    }
    
    
    res.status(200).json(resJson)




}