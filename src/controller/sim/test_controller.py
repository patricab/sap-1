import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue

SIG_HLT       = 11;
SIG_PC_INC    = 10;
SIG_PC_EN     = 9;
SIG_MEM_LOAD  = 8;
SIG_MEM_EN    = 7;
SIG_IR_LOAD   = 6;
SIG_IR_EN     = 5;
SIG_A_LOAD    = 4;
SIG_A_EN      = 3;
SIG_B_LOAD    = 2;
SIG_ADDER_SUB = 1;
SIG_ADDER_EN  = 0;

OP_NOP = 0;
OP_LDA = 1;
OP_ADD = 2;
OP_SUB = 3;
OP_STA = 4;
OP_LDI = 5;
OP_JMP = 6;
OP_JC  = 7;
OP_JZ  = 8;
OP_OUT = int("E", 16);
OP_HLT = int("F", 16);

@cocotb.test()
async def fetch_pc(dut):
    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    ctrl = 0

    # Reset
    dut.rst = 1
    dut.opcode = OP_NOP
    await Timer(10, units="us")
    dut.rst = 0

    # Stage 0
    ctrl = 1 << SIG_PC_EN | 1 << SIG_MEM_LOAD
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 0 mismatch"
    await Timer(10, units="us")
    
    # Stage 1
    ctrl = 1 << SIG_PC_INC
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 1 mismatch"
    await Timer(10, units="us")
    
    # Stage 2
    ctrl = 1 << SIG_MEM_EN | 1 << SIG_IR_LOAD
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 2 mismatch"
    
@cocotb.test()
async def lda(dut):
    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    ctrl = 0

    # Reset
    dut.rst = 1
    dut.opcode = OP_LDA
    await Timer(10, units="us")
    dut.rst = 0

    # Wait for PC fetch to finish
    await Timer(30, units="us")

    # Stage 3
    ctrl = 1 << SIG_MEM_LOAD | 1 << SIG_IR_EN 
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 3 mismatch"
    await Timer(10, units="us")
    
    # Stage 4
    ctrl = 1 << SIG_MEM_EN | 1 << SIG_A_LOAD
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 4 mismatch"

@cocotb.test()
async def add(dut):
    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    ctrl = 0

    # Reset
    dut.rst = 1
    dut.opcode = OP_ADD
    await Timer(10, units="us")
    dut.rst = 0

    # Wait for PC fetch to finish
    await Timer(30, units="us")

    # Stage 3
    ctrl =  1 << SIG_MEM_LOAD | 1 << SIG_IR_EN
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 3 mismatch"
    await Timer(10, units="us")
    
    # Stage 4
    ctrl =   1 << SIG_MEM_EN | 1 << SIG_B_LOAD
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 4 mismatch"
    await Timer(10, units="us")

    # Stage 5
    ctrl =  1 << SIG_A_LOAD | 1 << SIG_ADDER_EN
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 5 mismatch"

@cocotb.test()
async def sub(dut):
    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    ctrl = 0

    # Reset
    dut.rst = 1
    dut.opcode = OP_SUB
    await Timer(10, units="us")
    dut.rst = 0

    # Wait for PC fetch to finish
    await Timer(30, units="us")

    # Stage 3
    ctrl =  1 << SIG_MEM_LOAD | 1 << SIG_IR_EN
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 3 mismatch"
    await Timer(10, units="us")
    
    # Stage 4
    ctrl = 1 << SIG_MEM_EN | 1 << SIG_B_LOAD
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 4 mismatch"
    await Timer(10, units="us")

    # Stage 5
    ctrl = 1 << SIG_A_LOAD | 1 << SIG_ADDER_SUB | 1 << SIG_ADDER_EN
    print(dut.out.value.binstr)
    assert dut.out.value == ctrl, "Stage 5 mismatch"