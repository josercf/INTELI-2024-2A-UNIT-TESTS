const assert = require('chai').assert;
const massaSalarialService = require('../service/massaSalarial.service');

describe('Massa Salarial Service', () => {
    it('Deve calcular corretamente a massa salarial', () => {
        const folhaDePagamento = [
            { salario: 1000, prolabore: 500, inss: 200, fgts: 80 },
            { salario: 1500, prolabore: 600, inss: 300, fgts: 100 }
        ];

        const massaSalarial = massaSalarialService.calcularMassaSalarial(folhaDePagamento);

        assert.equal(massaSalarial, 4280);
    });

    it('Deve lançar erro se a folha de pagamento for inválida', () => {
        assert.throws(() => massaSalarialService.calcularMassaSalarial(null), Error, 'Folha de pagamento inválida');
    });
});
