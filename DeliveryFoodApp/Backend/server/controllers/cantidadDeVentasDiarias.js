import {connect} from '../databases/mysqlDatabase';
import jwt from  'jsonwebtoken';



export async function CantidadDeVentasDiarias(req, res) {

    const authorization = req.get('authorization');

    let token = '';

    if (authorization && authorization.toLowerCase().startsWith('bearer')) {
        token = authorization.substring(7)
    }
    let decodeToken = {};


    if (token.length > 0) {
        decodeToken = jwt.verify(token, 'cfiifcas7mert')
    } else {
        return res.status(401)
    }

    if (!token || !decodeToken.id) {
        return res.status(401).json({ error: 'unauthorized' })
    }


    const db = await connect()

    let hoy = new Date().toLocaleDateString()
    let cantidadDeVentas = 0
    let montoTotal = 0;

    const [orders] = await db.query(
        'select * from orders',
    )
    const [ventas] = await db.query(
        'select * from ventasDiarias where fecha = ?',
        [hoy]
    )


    if (ventas.length > 0) {


        let i = 0
        while (orders.length > i) {
            const [fecha] = await db.query(
                'select * from fechas where id = ?',
                [orders[i].idFecha]
            )

            if (fecha[0].fecha === hoy) {
                let productId = orders[i].product_id

                const [producto] = await db.query(
                    'select * from productos where id = ?',
                    [productId]
                )
                let j = 0

                while (orders[i].cantidad > j) {
                    montoTotal += producto[0].price
                    j++
                }


                cantidadDeVentas++
            }


            i++
        }




        await db.query('update ventasDiarias set cantidadDeVentas = ?,MontoTotal = ? where fecha = ?',
            [cantidadDeVentas, montoTotal, hoy]
        )




    } else {
        let i = 0
        while (orders.length > i) {
            const [fecha] = await db.query(
                'select * from fechas where id = ?',
                [orders[i].idFecha]
            )

            if (fecha[0].fecha === hoy) {
                let productId = orders[i].product_id

                const [producto] = await db.query(
                    'select * from productos where id = ?',
                    [productId]
                )
                let j = 0

                while (orders[i].cantidad > j) {
                    montoTotal += producto[0].price
                    j++
                }


                cantidadDeVentas++
            }


            i++
        }

        await db.query('insert into ventasDiarias(fecha,cantidadDeVentas,MontoTotal) values(?,?,?)',
            [hoy, cantidadDeVentas, montoTotal]
        )

    }




    res.status(200).json({
        montoTotal: montoTotal,
        cantidadDeVentas: cantidadDeVentas,
    })




}