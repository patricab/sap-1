import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue

@cocotb.test()
async def add(dut):
    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock
    dut.rst = 1
    dut.add = dut.sub = 0
    dut.load_a = dut.load_b = dut.enable_a = dut.enable_b = 1
    await Timer(10, units="us")
    dut.rst = 0

    # Load A/B
    dut.load_a = 0
    dut.load_b = 0
    dut.a = 2
    dut.b = 2
    await Timer(10, units="us")
    dut.load_a = 1
    dut.load_b = 1

    # Execute ALU
    dut.add = 1
    dut.enable_a = 0
    dut.enable_b = 0
    await Timer(10, units="us")
    dut.enable_a = 1
    dut.enable_b = 1

    # Check output
    await Timer(10, units="us")
    await RisingEdge(dut.clk)
    print(dut.out.value.binstr)
    assert dut.out.value == 4, "Mismatch in addition"

@cocotb.test()
async def sub(dut):
    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock
    dut.rst = 1
    dut.add = dut.sub = 0
    dut.load_a = dut.load_b = dut.enable_a = dut.enable_b = 1
    await Timer(10, units="us")
    dut.rst = 0

    # Load A/B
    dut.load_a = 0
    dut.load_b = 0
    dut.a = 2
    dut.b = 2
    await Timer(10, units="us")
    dut.load_a = 1
    dut.load_b = 1

    # Execute ALU
    dut.sub = 1
    dut.enable_a = 0
    dut.enable_b = 0
    await Timer(10, units="us")
    dut.enable_a = 1
    dut.enable_b = 1

    # Check output
    await Timer(10, units="us")
    await RisingEdge(dut.clk)
    print(dut.out.value.binstr)
    assert dut.out.value == 4, "Mismatch in subtraction"

