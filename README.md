# Matrix Multiplication Accelerator (Verilog)

This project implements a 4×4 matrix multiplication accelerator using Verilog. It is designed to offload dense matrix operations from general-purpose logic, using FSM-based control and a reusable multiply-accumulate (MAC) datapath to achieve correct functionality with minimal hardware cost.

## Overview

- Computes matrix **C = A × B**, where A and B are 4×4 matrices of 8-bit integers.
- Internally uses **flattened 128-bit input vectors** (for both A and B), which are sliced into 2D arrays for indexed row-column traversal.
- A **6-state FSM** manages control flow: input traversal, MAC enablement, partial accumulation, and result storage into output matrix `C`.
- A single **MAC datapath** computes dot products across cycles, trading performance for lower area utilization.

## Testing

- Verified using Verilog testbench with hardcoded and dynamic input matrices.  
- Inspected waveforms via GTKWave to ensure correct sequencing and accumulation behavior.  
- Output matrix printed row-wise to visualize the final result.

## Files

- `fsm.v` – Core FSM + control logic to sequentially send a,b and enable signals to the MAC unit
- `mac.v` – Multiply-accumulate datapath module which computes the dot product of a single row and column, sends it to the fsm module for storage
- `top_module.v` – Top-level integration of FSM, MAC, and IO ports  
- `top_module_tb.v` – Testbench for verification  
- `README.md` – This documentation

## Next Steps

- Parameterize matrix size for scalability  
- Add streaming input support or memory-mapped interfaces  
- Begin formal/automated verification using [Cocotb](https://github.com/cocotb/cocotb)  
- Explore parallelization (e.g., row-wise dot products with multiple MACs)


**Author:** Kshitij Dutta  
www.linkedin.com/in/kshitij-dutta-2726a7259
**License:** Open to educational use  
