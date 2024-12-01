const express = require('express');
const { createAOrder, getOrderByEmail } = require('./order.controller');

const router =  express.Router();

// Add logging middleware for all order routes
router.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] Order API Hit - ${req.method} ${req.originalUrl}`);
  next();
});

// create order endpoint
router.post("/", createAOrder);

// get orders by user email 
router.get("/email/:email", getOrderByEmail);

module.exports = router;