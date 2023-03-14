import express from 'express';
const ProductsRoute = require('./router/ProductsRoutes')
const UserRoutes = require('./router/userRoutes');
const adminRoutes = require('./router/adminRoutes');
const app = express();
import cors from 'cors';
import multer from 'multer';
import morgan from 'morgan';
const path = require('path');
const uuid = require('uuid');

app.use(express.json());
app.use(express.static(path.join(__dirname,'public')))
//app.use(cors);
app.use(morgan('dev'));
app.use(express.urlencoded({extended: true}));
const storage = multer.diskStorage({
    destination: path.join('./','public/images'),
    filename: (req,file,cb,filename) => {

        cb(null,uuid.v4()+'.jpg');
    }
});
app.use(multer({storage: storage }).single('image'));

app.get('/', (req, res) => {
    res.send('home')
})

app.use('/', ProductsRoute);
app.use('/',UserRoutes);
app.use('/',adminRoutes);

app.listen(3200,() => console.log('listening on port 3200'))