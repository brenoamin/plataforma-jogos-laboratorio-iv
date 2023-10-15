<h1 id="inicio" align="center">
  <br>
  <img src="../assets/chip.png" alt="A chip logo" height="100">
  <br>

Processador para Jogos

</h1>

[< Voltar](../README.md)

## Dúvidas resolvidas

1. Read after Write: Se eu querer escrever um valor e ler em menos de N instruções, pode ser que ele não tenha chegado lá o valor ainda.

> Solução que encontramos: quantidade de NOPs no decoder da instrução
> Solução apresentada pelo professor:
> ```
> ADD R5 R6
> SUB R6 R7 
> AND R5 R6  <- pendente de resultado de R5, R6
> ```
> 
> Registrador de status dos registradores, contabilizando quantos "clocks" faltam para ficar em 0 (0=dado pronto), 3,2,1...

2. Ao usar uma condição de desvio, as instruções que já estavam no ciclo de instrução chegarão no pipeline.

> Solução que encontramos: "Resetar" as instruções anteriores, ou uma flag para instrução descartada, basta não mexer na pilha e na memória

3. Pra que é aquele +4 no PC?
> Para acessar de byte em byte partes de uma instrução 

4. Mais informações sobre o RFLag
> RFlags -> Retrato de instruções
> Eles devem ser atualizados a cada instrução, talvez carregar ele na pipeline
> 
> overflow = ADD and SUB
> 
> [above; equal; below] = [>, <, ==]
> 
> between = está relacionado como o SPRITE_COLLISION_BG, verificar se valores estão nos limites
> 
> collision = está relacionado com o SPRITE_COLLISION_SP, verificar se dois levles colidiram
> 
> error = divisão por 0, pilha cheia, pilha vazia

## Dúvidas abertas
✅ Tudo certo por enquanto

