import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge

@cocotb.test()
async def test_reg(dut):
    """ Test that d propagates to q """

    clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    # for i in range(10):
    # val = random.randint(0, 1)
    # dut.d.value = val  # Assign the random value val to the input port d
    reg = [1, 0, 1, 0, 1, 0, 1, 0]
    dut.rst.value = 1
    dut.enable_n.value = 1
    dut.load_n.value = 0
    dut.rst.value = 0

    dut.reg_in.value = reg

    dut.load_n.value = 1
    dut.enable_n.value = 0
    # await RisingEdge(dut.clk)
    await Timer(250, units="ns")
    assert dut.reg_out.value == reg, "output was incorrect on the {}th cycle"
