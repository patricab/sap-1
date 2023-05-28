module Reg #(regff
    parameter WIDTH = 8
) (
    input logic clk, rst,
    input logic load,
    input logic [WIDTH-1:0] reg_in,
    output logic [WIDTH-1:0] reg_out
);

reg [7:0] internal;
    
always @(posedge clk) 
begin 
    // Load signal
    if (rst) begin
       internal <= 8'b0;
    end else begin
        if (load == 1'b1 ) begin
            internal <= reg_in;
        end
    end

    reg_out <= internal; 
end

// Dump waves
// initial begin
//     $dumpfile("dump.vcd");
//     $dumpvars(1, Reg);
// end

endmodule
