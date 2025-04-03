# MIPS-32bit-
MIPS 32-bit Processor

Overview:
This project implements a MIPS 32-bit Single-Cycle Processor using Verilog. The design follows the MIPS architecture and includes key components such as the ALU, Control Unit, Register File, and Memory modules. The project also includes a comprehensive testbench for functional verification.

Features:
- Single-Cycle Execution: Each instruction executes in a single clock cycle.
- MIPS Instruction Set Support: Implements a subset of MIPS instructions, including arithmetic, logical, memory, and control operations.
- Modular Design: Each functional unit is implemented as a separate Verilog module.
- Testbench Included: A complete testbench to verify the functionality of the processor.

Project Structure:
MIPS-32bit/
- src/                Verilog source files
  - ALU.v          Arithmetic Logic Unit
  - ALU_Control.v  ALU Control Unit
  - Control.v      Main Control Unit
  - Datapath.v     Datapath connecting all components
  - RegisterFile.v Register File Implementation
  - Memory.v       Instruction and Data Memory
  - MIPS_Top.v     Top-Level module integrating all components
- README.txt         Project description

Installation & Usage:
Prerequisites:
- Verilog simulation tools such as ModelSim, Icarus Verilog, Quartus
- Git for version control


Future Improvements:
- Implement Pipelined and Multi-Cycle versions
- Add support for floating-point operations
- Improve hazard detection and forwarding mechanisms

