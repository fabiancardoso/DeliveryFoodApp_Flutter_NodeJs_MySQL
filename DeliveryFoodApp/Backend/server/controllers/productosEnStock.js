import {connect} from '../databases/mysqlDatabase';

export const productosEnStock = async (req,res) => {
        
        const db = await connect()

        const [productos] = await db.query(
                'select * from productos'
        )
        
        
        res.json(productos)
}