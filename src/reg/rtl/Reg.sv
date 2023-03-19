module Reg #(
    parameter WIDTH = 8
) (
    input logic clk, rst,
    input logic load_n, enable_n,
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
        if (load_n == 1'b0 ) begin
            internal <= reg_in;
        end
    end

    reg_out <= internal; 
    // if (enable_n == 1'b0) begin
    //     reg_out <= internal; 
    // end else begin
    //     reg_out <= reg_out; 
    // end
end

// Dump waves
// initial begin
//     $dumpfile("dump.vcd");
//     $dumpvars(1, Reg);
// end

endmodule
