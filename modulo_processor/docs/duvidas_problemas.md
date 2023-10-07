<h1 id="inicio" align="center">
  <br>
  <img src="../assets/chip.png" alt="A chip logo" height="100">
  <br>

Processador para Jogos

</h1>

[< Voltar](../README.md)

## Possíveis problemas

1. Read after Write: Se eu querer escrever um valor e ler em menos de N instruções, pode ser que ele não tenha chegado lá o valor ainda.

> Solução que encontramos: quantidade de NOPs no decoder da instrução

2. Ao usar uma condição de desvio, as instruções que já estavam no ciclo de instrução chegarão no pipeline.

> Solução que encontramos: "Resetar" as instruções anteriores

## Dúvidas

- +4 no PC
- RFlag
