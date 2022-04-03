// Importing express module
const express=require("express");
const path = require('path');
const router=express.Router()
  
// Handling request using router
router.get("/",(req,res,next)=>{
    console.log("estoy en parcelas");
    res.sendFile(path.join(__dirname, '../parcelas.html'));
})
  
// Importing the router
module.exports=router