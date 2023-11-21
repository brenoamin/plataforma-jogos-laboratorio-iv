
# Entity: fetch 
- **File**: fetch.v

## Diagram
![Diagram](fetch.svg "Diagram")
## Generics

| Generic name | Type | Value | Description |
| ------------ | ---- | ----- | ----------- |
| AWIDTH       |      | 15    |             |
| DWIDTH       |      | 32    |             |

## Ports

| Port name     | Direction | Type              | Description |
| ------------- | --------- | ----------------- | ----------- |
| clk           | input     | wire              |             |
| rst           |           |                   |             |
| fetch_addr    | input     | wire [AWIDTH-1:0] |             |
| fetch_instr   | input     | wire [DWIDTH-1:0] |             |
| fetched_addr  | output    | [AWIDTH-1:0]      |             |
| fetched_instr | output    | [DWIDTH-1:0]      |             |

## Processes
- FETCH: ( @(posedge clk, posedge rst) )
  - **Type:** always
