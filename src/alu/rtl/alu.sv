module alu #(
    parameter WIDTH = 8
) (
    input logic sum, sub,
    input logic [WIDTH-1:0] a, b,
    output logic [WIDTH-1:0] out,
    //output logic carry
    output logic carry, zero
);

reg[WIDTH:0] im;

always_comb begin : behaviour
    if (sum) begin
        im = a + b;
    end else if (sub) begin
        im = a - b;
        if (im == 0) begin
            zero = 1;
        end
    end
    out = im[WIDTH-1:0];
    carry = im[WIDTH];
end


// Dump waves
// initial begin
//     $dumpfile("alu.vcd");
//     $dumpvars(1, alu);
// end
    
endmodule
