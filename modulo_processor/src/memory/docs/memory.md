
# Entity: memory 
- **File**: memory.v
- **Title:**  Memória de Programa
- **Author:**  @brenoamin, @taffarel55

## Diagram
![Diagram](memory.svg "Diagram")
## Description

A Memória de Programa é um componente que armazena as instruções de um programa
e permite a leitura e escrita de dados com base em endereços de memória.
Este módulo Verilog representa uma memória de programa parametrizável.

## Generics

| Generic name | Type    | Value | Description                    |
| ------------ | ------- | ----- | ------------------------------ |
| AWIDTH       | integer | 15    | Largura do endereço da memória |
| DWIDTH       | integer | 32    | Largura dos dados armazenados  |
| INIT_MEMORY  |         | ""    |                                |

## Ports

| Port name | Direction | Type              | Description                           |
| --------- | --------- | ----------------- | ------------------------------------- |
| addr      | input     | wire [AWIDTH-1:0] | Entrada de endereço de memória        |
| wr        | input     | wire              | Sinais de escrita (wr) e leitura (rd) |
| rd        |           |                   | Sinais de escrita (wr) e leitura (rd) |
| data_in   | input     | wire [DWIDTH-1:0] | Dados de entrada para escrita         |
| data_out  | output    | wire [DWIDTH-1:0] | Dados lidos da memória                |

## Signals

| Name                   | Type             | Description                        |
| ---------------------- | ---------------- | ---------------------------------- |
| memory [0:2**AWIDTH-1] | reg [DWIDTH-1:0] | Memória de programa parametrizável |
| rdata                  | reg [DWIDTH-1:0] | Dados lidos da memória             |

## Processes
- MEMORY_ACCESS: ( @(wr, rd, addr) )
  - **Type:** always
  - **Description**
  Lógica para determinar a saída de dados da memória  Lógica para escrita e leitura de dados na memória 
