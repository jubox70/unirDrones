// Importing express module
const express=require("express");
const path = require('path');
const router=express.Router()
  
// Handling request using router
router.get("/",(req,res,next)=>{
  console.log("estoy en home");
  res.sendFile(path.join(__dirname, '../index.html'));
})
  
// Importing the router
module.exports=router