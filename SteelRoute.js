// https://stackoverflow.com/questions/35699095/how-to-pass-data-from-angularjs-frontend-to-nodejs-backend/35699700#35699700
// https://stackoverflow.com/questions/44707391/retrieving-data-from-mysql-with-angularjs-and-nodejs
// https://github.com/mysqljs/mysql

const express = require('express');
const BodyParser = require('body-parser');
const MySqlConn = require('../config/connect');

const SteelRouter = express.Router();
express().set('view engine','ejs');

SteelRouter.use(BodyParser.urlencoded({extended : true}));
SteelRouter.use(BodyParser.json());

// HOME PAGE
SteelRouter.get('/', (req,res) => {res.render('Steel.ejs')});

// TMT PRODUCTION ENTRY
SteelRouter.post('/production', (req,res) => {
    const ObjProd = [
        req.body.DtEntry,
        req.body.job
    ];
    const SsQl = "CALL SpSteelProductionDate(?,?)";
    MySqlConn.query(SsQl, ObjProd, (err,data,fields) => {
        if(err) {
            res.send('ERROR');
        }
        else {
            const Job = {
                JobDate : ObjProd[0],
                JobCode : ObjProd[1],
                JobDesc : (ObjProd[1] == "03") ? "FURNACE OIL & POWER" : (ObjProd[1] == "01") ? "SLSL PRODUCTION" : "MITTAL CONVERSION",
                Product : data[0]
            };
            // res.json(Job);
            if(Job.JobCode == "03") {
                res.render('ProdFo.ejs', {"MyJob" : Job});
            }
            else {
                res.render('ProdTmt.ejs', {"MyJob" : Job});
            }
        }
    });
});

// TMT PRODUCTION SAVE
SteelRouter.post('/production/tmt', (req,res) => {
    const ObjProd = [
        req.body.JobDate,
        req.body.JobCode,
        req.body.Billet,
        req.body.Tmt08,
        req.body.Tmt10,
        req.body.Tmt12,
        req.body.Tmt16,
        req.body.Tmt20,
        req.body.Tmt25,
        req.body.Tmt28,
        req.body.Tmt32,
        req.body.MissRoll,
        req.body.MillScale,
        req.body.Scrap,
        'B426',
        'Y'
    ];
    const SsQl = "CALL SpSteelProductionTmt(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    MySqlConn.query(SsQl, ObjProd, (err,data,fields) => {
        if(err) {
            res.send('ERROR');
        }
        else {
            const Product = {
                Voucher : data[0]
            };
            res.json(Product);
            // res.render('ProdTmt.ejs', {"MyProduct" : Product});
        }
    });
});

// FO/POWER PRODUCTION SAVE
SteelRouter.post('/production/fo', (req,res) => {
    const ObjProd = [
        req.body.JobDate,
        req.body.Fo,
        req.body.Power,
        'B426',
        'Y'
    ];
    const SsQl = "CALL SpSteelProductionFo(?,?,?,?,?)";
    MySqlConn.query(SsQl, ObjProd, (err,data,fields) => {
        if(err) {
            res.send('ERROR');
        }
        else {
            const Product = {
                Voucher : data[0]
            };
            res.json(Product);
            // res.render('ProdTmt.ejs', {"MyProduct" : Product});
        }
    });
});

module.exports = SteelRouter;