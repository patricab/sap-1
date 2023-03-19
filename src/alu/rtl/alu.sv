module alu #(
    parameter WIDTH = 8
) (
    input wire sum, sub,
    input logic [WIDTH-1:0] a, b,
    output logic [WIDTH-1:0] out
);

always_comb begin : behaviour
    if (sum) begin
        if (sub) begin
            out = a - b;
        end else begin
            out = a + b;
        end
    end
end

// Dump waves
// initial begin
//     $dumpfile("alu.vcd");
//     $dumpvars(1, alu);
// end
    
endmodule