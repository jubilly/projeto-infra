import mysql from 'mysql';


async function connect(){
    const connection = await mysql.createConnection({
        host: "localhost",
        user: 'root',
        password: 'root',
        database: "infraestrutura"
    });
    
    console.log("Conectou no MySQL!");
    return connection;
}
