const massaSalarialService = require('../service/massaSalarial.service');

exports.calcularMassaSalarial = (req, res) => {
    const { folhaDePagamento } = req.body;
    const massaSalarial = massaSalarialService.calcularMassaSalarial(folhaDePagamento);
    res.status(200).json({ massaSalarial });
};
