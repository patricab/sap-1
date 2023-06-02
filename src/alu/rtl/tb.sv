module tb (
    input logic clk, rst,
    input logic add, sub, fi,
    input logic en_a, en_b, load_a, load_b,
    input logic [7:0] a, b,
    output logic [7:0] out,
    output logic carry, zero
);

logic [7:0] _a, _b;

Reg A (clk, rst, en_a, load_a, a, _a);
Reg B (clk, rst, en_b, load_b, b, _b);
alu ALU(clk, rst, add, sub, fi, _a, _b, out, carry, zero);

// Dump waves
// initial begin
//     $dumpfile("tb.vcd");
//     $dumpvars(1, tb);
// end

endmodule
