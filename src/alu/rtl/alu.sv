module alu #(
    parameter WIDTH = 8
) (
    input logic clk, rst,
    input logic enable, sub, fi,
    input logic [WIDTH-1:0] a, b,
    output logic [WIDTH-1:0] out,
    output logic carry, zero
);

reg[WIDTH:0] im;
reg[1:0] flags; // 1: Carry, 0: Zero

// always @(posedge clk) begin
always_comb begin
    if (rst) begin
        im = 8'b0;
        out = 8'b0;
        flags = 2'b0;
    end else if (sub) begin
        im = a - b;
        if (im == 0) begin
            flags[0] = 1; // Zero end
        end
    end else begin
        im = a + b;
    end

    flags[1] = im[WIDTH]; // Carry

    // Enable outputs
    if (enable) begin
        out = im[WIDTH-1:0];
    end 
    if (fi) begin
        carry = flags[1];
        zero = flags[0];
    end
end

// Dump waves
//initial begin
//    $dumpfile("alu.vcd");
//    $dumpvars(1, alu);
//end
    
endmodule
