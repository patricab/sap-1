module tb (
    input logic clk, rst,
    input logic add, sub,
    input logic load_a, load_b,
    input logic [7:0] a, b,
    output logic [7:0] out
);

logic [7:0] _a, _b;

Reg A (clk, rst, load_a, a, _a);
Reg B (clk, rst, load_b, b, _b);
alu ALU(add, sub, _a, _b, out);

// Dump waves
initial begin
    $dumpfile("tb.vcd");
    $dumpvars(1, tb);
end


endmodule
