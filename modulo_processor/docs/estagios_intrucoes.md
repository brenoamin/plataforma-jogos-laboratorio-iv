<h1 id="inicio" align="center">
  <br>
  <img src="../assets/chip.png" alt="A chip logo" height="100">
  <br>

Processador para Jogos

</h1>

[< Voltar](../README.md)

## LW:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê conteúdo de Rb e salva em Rd1
  - Extende o imediato
- Execute:
  - Soma imediato com Rd1, calculando um endereço de base deslocamento
- Memory:
  - Usa valor da ULA como endereço para acessar a memória
  - Pega o valor que estava armazenado neste endereço e
- Writeback:
  - Usa o valor da memória
  - Escreve do banco de registradores

## SW:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê contúdo de Rs e salva em Rd2
  - Lê conteúdo de Rb e salva em Rd1
  - Extende o imediato
- Execute:
  - Soma imediato com Rd1, calculando um endereço de base deslocamento
- Memory:
  - Este endereço vai ser usado para armazenar o valor Rd2
- Writeback:
  - Disabled

## MOV:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê conteúdo de Rs e salva em Rd1
  - Salva o valor de R0 em Rd2
- Execute:
  - Executa uma soma na ULA com Rd1 e Rd2
- Memory:
  - Disabled
- Writeback:
  - Salva Data em Rd

## ULA:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê conteúdo de Rs e salva em Rd1
  - Lê conteúdo de Rd e salva em Rd2
- Execute:
  - Executa uma operação na ULA com Rd1 e Rd2
- Memory:
  - Disabled
- Writeback:
  - Salva Data em Rd

> Operação CMP modifica o RFlags

## JR:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê conteúdo de R e salva em Rd
- Execute:
  - Salva R_abs com valor de Rd
  - Seta flags para reset dos estágios anteriores
- Memory:
  - Disabled
- Writeback:
  - Disabled

## JPC:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê conteúdo de R e salva em Rd
  - Extende imediato
- Execute:
  - Soma imediato com Rd + 1
  - Salva R_abs com este valor
  - Seta flags para reset dos estágios anteriores
- Memory:
  - Disabled
- Writeback:
  - Disabled

## BRFL:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê conteúdo de R e salva em Rd
- Execute:
  - Compara RFlag com I
  - Salva R_abs com valor de Rd
  - Seta flags para reset dos estágios anteriores
- Memory:
  - Disabled
- Writeback:
  - Disabled

## CALL:

- Fetch:
  - Obtém a instrução
- Decode:
  - Lê conteúdo de R e salva em Rd
- Execute:
  - Armazena na pilha endereço atual ADDR
  - Salva R_abs com valor de Rd
  - Seta flags para reset dos estágios anteriores
- Memory:
  - Disabled
- Writeback:
  - Disabled

## CALL:

- Fetch:
  - Obtém a instrução
- Decode:
  - Disabled
- Execute:
  - Lê ultimo endereço da pilha
  - Salva este endereço em R_abs
  - Seta flags para reset dos estágios anteriores
- Memory:
  - Disabled
- Writeback:
  - Disabled
