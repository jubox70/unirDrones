const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 8080;

const homeRoute = require("./routes/home.js");
const dronesRoute = require("./routes/drones.js");
const parcelasRoute = require("./routes/parcelas.js");
  
// Handling routes request
app.use("/", homeRoute);
app.use("/drones", dronesRoute);
app.use("/parcelas", parcelasRoute);
app.use('/static', express.static(__dirname + '/static'));
app.listen((port),()=>{
    console.log("Server is Running");
});

