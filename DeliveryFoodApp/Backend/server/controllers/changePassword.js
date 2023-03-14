const bcrypt = require('bcrypt');
import jwt from 'jsonwebtoken';
import {connect} from '../databases/mysqlDatabase';

export const ChangePassowrd = async (req, res) => {
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

    const password = await bcrypt.hash(req.body.password, 10)
    const db = await connect();
    const [user] = await db.query('select * from clients where name = ?',
        [decodeToken.name]
    )
    if (user.length == 0) {
        return res.status(403).send();
    } else {


        db.query(
            'update clients set password = ? where name = ?',
            [password, decodeToken.name]
        )

        [user] = await db.query('select * from clients where name = ?',
            [decodeToken.name]
        )



        res.status(201).send()




    }





}