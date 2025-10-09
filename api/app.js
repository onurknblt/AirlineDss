var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require('cors');

const demandRouter = require('./routes/demandRoutes');
const revenueRouter = require('./routes/revenueRoutes');
const dashboardRouter = require('./routes/dashboardRoutes');
const whatIfRouter = require('./routes/whatIfRoutes');
const aircraftRouter = require('./routes/aircraftRoutes');
const authRouter = require('./routes/authRoutes');


var app = express();

app.use(cors());

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/demand', demandRouter);
app.use('/revenue', revenueRouter);
app.use('/dashboard', dashboardRouter);
app.use('/what-if', whatIfRouter);
app.use('/aircraft', aircraftRouter);
app.use('/auth', authRouter);




app.listen(3000, () => {
    console.log('API uygulaması 3000 portunda çalışıyor');
});


module.exports = app;
