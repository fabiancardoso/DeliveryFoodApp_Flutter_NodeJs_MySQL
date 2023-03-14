
import {connect} from '../databases/mysqlDatabase';

export const findProducts = async (req,res) => {
        
        const db = await connect()

        const query = req.body.params

        const [productos] = await db.query(
                'select * from productos'
        )
        
        const resp = productos.filter(function(item){
                const product = item.name
                return product.toLowerCase().indexOf(query.toLowerCase()) > -1;
        }) 

        

        
        res.json(resp)
    
}

