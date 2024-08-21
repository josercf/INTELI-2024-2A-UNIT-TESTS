const express = require('express');
const router = express.Router();
const massaSalarialController = require('../controller/massaSalarial.controller');

router.post('/calcular', massaSalarialController.calcularMassaSalarial);

module.exports = router;
