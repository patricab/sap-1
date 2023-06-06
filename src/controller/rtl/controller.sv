module controller(
	input clk,
	input rst,
	input[3:0] opcode,
	output[11:0] out
);

localparam FI  = 15;
localparam JMP = 14;
localparam CO  = 13;
localparam CI  = 12;
localparam OI  = 11;
localparam BI  = 10;
localparam SUB = 9;
localparam ALO = 8
localparam AI  = 7;
localparam AO  = 6;
localparam II  = 5;
localparam IO  = 4;
localparam RI  = 3;
// localparam RO  = 2;
localparam MI  = 1;
localparam HLT = 0;

localparam OP_LDA = 4'h01;
localparam OP_ADD = 4'h02;
localparam OP_SUB = 4'h03;
localparam OP_STA = 4'h04;
localparam OP_LDI = 4'h05;
localparam OP_JMP = 4'h06;
localparam OP_JC  = 4'h07;
localparam OP_JZ  = 4'h08;
localparam OP_OUT = 4'h0E;
localparam OP_HLT = 4'h0F;

reg[3:0]  stage;
reg[11:0] ctrl_word;

always @(negedge clk, posedge rst) begin
	if (rst) begin
		stage <= 0;
	end else begin
		if (stage == 5) begin
			stage <= 0;
		end else begin
			stage <= stage + 1;
		end
	end
end

always @(*) begin
	ctrl_word = 12'b0;

	case (stage)
		0: begin
			ctrl_word[CO] = 1;
			ctrl_word[MI] = 1;
		end
		1: begin
			ctrl_word[MI] = 1;
		end
		2: begin
			ctrl_word[II] = 1;
			ctrl_word[CI] = 1;
		end
		3: begin
			case (opcode)
				OP_LDA: begin
					ctrl_word[IO] = 1;
					ctrl_word[MI] = 1;
				end
				OP_ADD: begin
					ctrl_word[IO] = 1;
					ctrl_word[MI] = 1;
				end
				OP_SUB: begin
					ctrl_word[IO] = 1;
					ctrl_word[MI] = 1;
				end
				OP_HLT: begin
					ctrl_word[SIG_HLT] = 1;
				end
			endcase
		end
		4: begin
			case (opcode)
				OP_LDA: begin
					ctrl_word[MI] = 1;
				end
				OP_ADD: begin
					ctrl_word[MI] = 1;
				end
				OP_SUB: begin
					ctrl_word[MI] = 1;
				end
			endcase
		end
		5: begin
			case (opcode)
				OP_LDA: begin
					ctrl_word[AI] = 1;
				end
				OP_ADD: begin
					ctrl_word[BI] = 1;
				end
				OP_SUB: begin
					ctrl_word[SIG_ADDER_SUB] = 1;
					ctrl_word[SIG_ADDER_EN] = 1;
					ctrl_word[SIG_A_LOAD] = 1;
				end
			endcase
		end
		6: begin
			case (opcode)
				OP_ADD: begin
					ctrl_word[ALO] = 1;
				end
				OP_SUB: begin
					ctrl_word[SUB] = 1;
					ctrl_word[ALO] = 1;
				end
			endcase
		end
		7: begin
			case (opcode)
				OP_ADD: begin
					ctrl_word[ALO] = 1;
				end
				OP_SUB: begin
					ctrl_word[ALO] = 1;
				end
			endcase
		end
		8: begin
			case (opcode)
				OP_ADD: begin
					ctrl_word[ALO] = 1;
					ctrl_word[AI] = 1;
					ctrl_word[FI] = 1;
				end
				OP_SUB: begin
					ctrl_word[ALO] = 1;
					ctrl_word[AI] = 1;
					ctrl_word[FI] = 1;
				end
			endcase
		end
	endcase
end

assign out = ctrl_word;

endmodule

