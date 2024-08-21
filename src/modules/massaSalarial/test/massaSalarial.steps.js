const { Given, When, Then } = require('cucumber');
const assert = require('chai').assert;
const massaSalarialService = require('../service/massaSalarial.service');

let folhaDePagamento;
let massaSalarial;

Given('que eu tenho uma folha de pagamento válida', function () {
    folhaDePagamento = [
        { salario: 1000, prolabore: 500, inss: 200, fgts: 80 },
        { salario: 1500, prolabore: 600, inss: 300, fgts: 100 }
    ];
});

When('eu enviar a folha de pagamento para o sistema', function () {
    massaSalarial = massaSalarialService.calcularMassaSalarial(folhaDePagamento);
});

Then('eu devo receber o total da massa salarial', function () {
    assert.equal(massaSalarial, 4280);
});
