import {config} from './userdb';
import mysql from 'mysql2/promise';

export async function connect(){
    return await mysql.createConnection(config);
} 