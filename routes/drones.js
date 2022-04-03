// Importing express module
const express=require("express");
const path = require('path');
const router=express.Router()
  
// Handling request using router
router.get("/",(req,res,next)=>{
    console.log("estoy en drones");
    res.sendFile(path.join(__dirname, '../drones.html'));
})
  
// Importing the router
module.exports=router