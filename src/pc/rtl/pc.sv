module pc #(
    parameter WIDTH = 8
) (
    input wire sum, sub,
    input logic [WIDTH-1:0] a, b,
    output logic [WIDTH-1:0] out
);
