module Reg (
    input wire load_n,
    input wire enable_n,
    input wire rst,
    input wire clk,
    input reg [7:0] reg_in,
    output reg[7:0] reg_out
);

reg [7:0] internal;
    
always @( posedge clk ) 
begin 
    // Load signal
    if (rst) begin
       internal <= 8'b0;
    end else begin
        if (load_n == 1'b0 ) begin
            internal <= reg_in;
        end
        else if (enable_n == 1'b0) begin
            reg_out <= internal; 
        end
    end
    
end

endmodule