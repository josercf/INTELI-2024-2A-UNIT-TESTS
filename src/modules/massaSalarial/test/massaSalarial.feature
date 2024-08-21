Feature: Calcular Massa Salarial
  Como um usuário do sistema
  Eu quero calcular a massa salarial da empresa
  Para poder obter o total dos últimos 12 meses

  Scenario: Calcular massa salarial com dados válidos
    Given que eu tenho uma folha de pagamento válida
    When eu enviar a folha de pagamento para o sistema
    Then eu devo receber o total da massa salarial
