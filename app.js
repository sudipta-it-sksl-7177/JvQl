const express = require('express');
const path = require('path');
const SteelRoute = require('./app/routes/SteelRoute');

const app = express();

app.use(express.static('MyPrivateLocker'));
app.use('/steel',SteelRoute);

app.listen(3000, () => console.log('APP IS RUNNING ON PORT 3000'));