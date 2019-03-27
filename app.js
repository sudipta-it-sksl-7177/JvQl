const express = require('express');
const path = require('path');
const QlRoute = require('./app/routes/QlRoute');

const app = express();

app.use(express.static('MyPrivateLocker'));
app.use('/home',QlRoute);

app.listen(3000,() => console.log('APP IS RUNNING ON PORT 3000'));