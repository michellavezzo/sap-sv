module controller(
	input logic clk,
	input logic rst,
	input logic [3:0] opcode,
	output logic [11:0] out
);

parameter int SIG_HLT       = 11;
parameter int SIG_PC_INC    = 10;
parameter int SIG_PC_EN     = 9;
parameter int SIG_MEM_LOAD  = 8;
parameter int SIG_MEM_EN    = 7;
parameter int SIG_IR_LOAD   = 6;
parameter int SIG_IR_EN     = 5;
parameter int SIG_A_LOAD    = 4;
parameter int SIG_A_EN      = 3;
parameter int SIG_B_LOAD    = 2;
parameter int SIG_ADDER_SUB = 1;
parameter int SIG_ADDER_EN  = 0;

parameter logic [3:0] OP_LDA = 4'b0000;
parameter logic [3:0] OP_ADD = 4'b0001;
parameter logic [3:0] OP_SUB = 4'b0010;
parameter logic [3:0] OP_HLT = 4'b1111;

logic [2:0]  stage;
logic [11:0] ctrl_word;

always_ff @(negedge clk or posedge rst) begin
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

always_comb begin
	ctrl_word = 12'b0;

	case (stage)
		0: begin
			ctrl_word[SIG_PC_EN] = 1;
			ctrl_word[SIG_MEM_LOAD] = 1;
		end
		// ... [rest of the code remains mostly unchanged] ...
	endcase
end

assign out = ctrl_word;

endmodule
