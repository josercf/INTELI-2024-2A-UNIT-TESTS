# Criar o arquivo server.js com o conteúdo necessário para iniciar a API e expor as rotas
$serverContent = @"
const express = require('express');
const app = express();
const massaSalarialRoutes = require('./routes/massaSalarial.routes');
const fatorRRoutes = require('./routes/fatorR.routes');
const anexosRoutes = require('./routes/anexos.routes');
const dasRoutes = require('./routes/das.routes');

// Middleware
app.use(express.json());

// Rotas
app.use('/api/massaSalarial', massaSalarialRoutes);
app.use('/api/fatorR', fatorRRoutes);
app.use('/api/anexos', anexosRoutes);
app.use('/api/das', dasRoutes);

// Porta para o servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

module.exports = app;
"@
Set-Content -Path "server.js" -Value $serverContent

# Criar arquivos do módulo massaSalarial como exemplo e modelo

# Controller
$controllerContent = @"
const massaSalarialService = require('../service/massaSalarial.service');

exports.calcularMassaSalarial = (req, res) => {
    const { folhaDePagamento } = req.body;
    const massaSalarial = massaSalarialService.calcularMassaSalarial(folhaDePagamento);
    res.status(200).json({ massaSalarial });
};
"@
Set-Content -Path "src/modules/massaSalarial/controller/massaSalarial.controller.js" -Value $controllerContent

# Service
$serviceContent = @"
exports.calcularMassaSalarial = (folhaDePagamento) => {
    if (!folhaDePagamento || !Array.isArray(folhaDePagamento)) {
        throw new Error('Folha de pagamento inválida');
    }

    return folhaDePagamento.reduce((total, pagamento) => {
        return total + pagamento.salario + pagamento.prolabore + pagamento.inss + pagamento.fgts;
    }, 0);
};
"@
Set-Content -Path "src/modules/massaSalarial/service/massaSalarial.service.js" -Value $serviceContent

# Model (Opcional)
$modelContent = @"
class FolhaDePagamento {
    constructor(salario, prolabore, inss, fgts) {
        this.salario = salario;
        this.prolabore = prolabore;
        this.inss = inss;
        this.fgts = fgts;
    }
}

module.exports = FolhaDePagamento;
"@
Set-Content -Path "src/modules/massaSalarial/model/massaSalarial.model.js" -Value $modelContent

# Rota
$routeContent = @"
const express = require('express');
const router = express.Router();
const massaSalarialController = require('../controller/massaSalarial.controller');

router.post('/calcular', massaSalarialController.calcularMassaSalarial);

module.exports = router;
"@
Set-Content -Path "routes/massaSalarial.routes.js" -Value $routeContent

# Teste - BDD (Feature)
$featureContent = @"
Feature: Calcular Massa Salarial
  Como um usuário do sistema
  Eu quero calcular a massa salarial da empresa
  Para poder obter o total dos últimos 12 meses

  Scenario: Calcular massa salarial com dados válidos
    Given que eu tenho uma folha de pagamento válida
    When eu enviar a folha de pagamento para o sistema
    Then eu devo receber o total da massa salarial
"@
Set-Content -Path "src/modules/massaSalarial/test/massaSalarial.feature" -Value $featureContent

# Teste - BDD (Steps)
$stepsContent = @"
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
"@
Set-Content -Path "src/modules/massaSalarial/test/massaSalarial.steps.js" -Value $stepsContent

# Teste - Unitário
$unitTestContent = @"
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
"@
Set-Content -Path "tests/unit/massaSalarial.unit.test.js" -Value $unitTestContent

# Mensagem de conclusão
Write-Host "Arquivos do módulo massaSalarial e server.js criados com sucesso!"
