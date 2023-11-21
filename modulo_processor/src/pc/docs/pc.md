
# Entity: pc 
- **File**: pc.v
- **Title:**  PC
- **Author:**  taffarel55

## Diagram
![Diagram](pc.svg "Diagram")
## Description

Um Contador de Programa (PC) é um componente essencial
de uma Unidade Central de Processamento (CPU) que é
responsável por armazenar o endereço da próxima instrução
a ser executada em um programa. Este módulo Verilog
implementa um PC com entrada para o clock, sinal de reset,
instrução de entrada e seleção de operação, e uma saída
para o endereço da próxima instrução.

## Generics

| Generic name | Type | Value | Description                             |
| ------------ | ---- | ----- | --------------------------------------- |
| WORD_SIZE    |      | 32    | Tamanho da palavra de instrução em bits |
| ADDR_SIZE    |      | 14    | Tamanho do barramento de endereços      |

## Ports

| Port name | Direction | Type                 | Description            |
| --------- | --------- | -------------------- | ---------------------- |
| clk       | input     | wire                 | Entrada de clock       |
| rst       | input     | wire                 | Entrada reset síncrono |
| instr     | input     | wire [WORD_SIZE-1:0] | Entrada de instrução   |
| sel       | input     | wire [OPT_SIZE-1:0]  | Seletor                |
| out       | output    | [WORD_SIZE-1:0]      | Saída do PC            |

## Constants

| Name       | Type | Value | Description                |
| ---------- | ---- | ----- | -------------------------- |
| OPT_SIZE   |      | 2     | Tamanho do seletor em bits |
| NEXT_INSTR |      | 0     | Estado NEXT_INSTR          |
| KEEP_INSTR |      | 1     | Estado KEEP_INSTR          |
| LOAD_INSTR |      | 2     | Estado LOAD_INSTR          |

## Processes
- PC: ( @(posedge clk) )
  - **Type:** always
