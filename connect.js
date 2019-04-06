const mysql = require('mysql');
module.exports  = mysql.createPool({
    // host: '192.168.1.25',
    host: 'localhost',
    user: 'root',
    password: 'pass',
    database: 'erpdb',
    multipleStatements : true,
    connectionLimit : 10,
    connectTimeout : 20000
});