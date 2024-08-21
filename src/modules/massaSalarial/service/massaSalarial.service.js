exports.calcularMassaSalarial = (folhaDePagamento) => {
    if (!folhaDePagamento || !Array.isArray(folhaDePagamento)) {
        throw new Error('Folha de pagamento inválida');
    }

    return folhaDePagamento.reduce((total, pagamento) => {
        return total + pagamento.salario + pagamento.prolabore + pagamento.inss + pagamento.fgts;
    }, 0);
};
