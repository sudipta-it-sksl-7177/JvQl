// https://stackoverflow.com/questions/35699095/how-to-pass-data-from-angularjs-frontend-to-nodejs-backend/35699700#35699700
// https://stackoverflow.com/questions/44707391/retrieving-data-from-mysql-with-angularjs-and-nodejs

const express = require('express');
const BodyParser = require('body-parser');
const MySql = require('mysql');
const SqlConnfig = require('../config/connect');

const QlRouter = express.Router();

express().set('view engine','ejs');

QlRouter.use(BodyParser.urlencoded({extended : true}));
QlRouter.use(BodyParser.json());

QlRouter.get('/', (req,res) => {res.render('ProdHome.ejs')});

// QlRouter.post('/production', (req,res) => {
//     const ObjProd = {
//         JobDate : req.body.DtEntry,
//         JobCode : req.body.job,
//         JobDesc : (req.body.job=="01") ? "SLSL PRODUCTION" : "MITTAL CONVERSION",
//         BilOpen : 20,
//         TmtOpen : 30,
//         MrOpen : 10
//     };
//     res.render('ProdEntry.ejs', {"MyJob" : ObjProd});
// });

QlRouter.post('/production', (req,res) => {

    const ObjProd = {
        JobDate : req.body.DtEntry,
        JobCode : req.body.job
    };

    const MySqlConn = MySql.createConnection(SqlConnfig);
    MySqlConn.connect((err) => {
        if(!err) {
            console.log("Database is connected ... nn");    
        } else {
            console.log("Error connecting database ... nn");    
        }
    });

    // const SsQl = "CALL SpSteelStockDate(?,?);";
    const SsQl = "call SpSteelStockDate('" + req.body.DtEntry + "','" + req.body.job +"')";
    MySqlConn.query(SsQl,(err,data,fields) => {
        MySqlConn.end();
        if(err) {
            res.send('ERROR');
        }
        else {
            const Job = {
                JobDate : req.body.DtEntry,
                JobCode : req.body.job,
                JobDesc : (req.body.job=="01") ? "SLSL PRODUCTION" : "MITTAL CONVERSION",
                Prod : data[0]
            };
            // res.json(Job);
            res.render('ProdEntry.ejs', {"MyJob" : Job});
        }
    });
});


// QlRouter.get('getproddata', (req,res) => {
//     const ObjParam = {
//         JobDate : req.query.jobdate,
//         JobCode : req.query.jobcode
//     };
//     console.log(ObjParam);
//     const MySqlConn = MySql.createConnection(SqlConnfig);
//     MySqlConn.connect((err,conn) => {
//         if(err) {
//             res.send({ err });
//         }
//         else {
//             const SsQl = "CALL SpSteelStockDate(?,?)";
//             conn.query(SsQl,ObjParam, (err,data) => {
//                 if(err) {
//                     res.send({ err });
//                 }
//                 else {
//                     console.log(data);
//                     res.send({ data });
//                 }
//             });
//         }
//     });
//     MySqlConn.end();
// });

module.exports = QlRouter;