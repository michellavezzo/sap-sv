// Decodes given opcodes and outputs control words based on the current stage of execution. 
// The transition of the stage is handled using a clocked process.

module controller(
	input logic clk,
	input logic rst,
	input logic [3:0] opcode,
	output logic [11:0] out
);
// Control signals
parameter int SIG_HLT       = 11; // Sinal de parada (Halt execution)
parameter int SIG_PC_INC    = 10; // Incremento do PC (PC increment)
parameter int SIG_PC_EN     = 9;  // Adicionar valor de PC no Barramento (put the pc value to bus)
parameter int SIG_MEM_LOAD  = 8;  // (Registrador de Endereço da Memória)Carregar endereço de memoria vindo do PC 
parameter int SIG_MEM_EN    = 7;  // Adicionar valor da memória no Barramento
parameter int SIG_IR_LOAD   = 6;  // Carregar endereço do barramento no Registrador de instruçõe
parameter int SIG_IR_EN     = 5;  // Colocar valor do RI no barramento
parameter int SIG_A_LOAD    = 4;  // Carrega o valor do barramento para o registrador/acumulador A
parameter int SIG_A_EN      = 3;  // Coloca valor do reg/acc A no barramento
parameter int SIG_B_LOAD    = 2;  // Carrega o valor do barramento para o registrador B
parameter int SIG_ADDER_SUB = 1;  // Tipo de operação (+ ou -)
parameter int SIG_ADDER_EN  = 0;  // Colocar valor do Adder no Barramento


//                              opcode
parameter logic [3:0] OP_LDA = 4'b0000; // Carrega o valor da memória no reg_a.
parameter logic [3:0] OP_ADD = 4'b0001; // Adiciona valor da memória com o valor de reg_a e salva em reg_a
parameter logic [3:0] OP_SUB = 4'b0010; // Subtrai valor da memória com o valor de reg_a e salva em reg_a
parameter logic [3:0] OP_HLT = 4'b1111; // Parar execução do programa

// Stage é em que passo da execução está
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
		1: begin
			ctrl_word[SIG_PC_INC] = 1;
		end
		2: begin
			ctrl_word[SIG_MEM_EN] = 1;
			ctrl_word[SIG_IR_LOAD] = 1;
		end
		3: begin
			case (opcode)
				OP_LDA: begin
					ctrl_word[SIG_IR_EN] = 1;
					ctrl_word[SIG_MEM_LOAD] = 1;
				end
				OP_ADD: begin
					ctrl_word[SIG_IR_EN] = 1;
					ctrl_word[SIG_MEM_LOAD] = 1;
				end
				OP_SUB: begin
					ctrl_word[SIG_IR_EN] = 1;
					ctrl_word[SIG_MEM_LOAD] = 1;
				end
				OP_HLT: begin
					ctrl_word[SIG_HLT] = 1;
				end
			endcase
		end
		4: begin
			case (opcode)
				OP_LDA: begin
					ctrl_word[SIG_MEM_EN] = 1;
					ctrl_word[SIG_A_LOAD] = 1;
				end
				OP_ADD: begin
					ctrl_word[SIG_MEM_EN] = 1;
					ctrl_word[SIG_B_LOAD] = 1;
				end
				OP_SUB: begin
					ctrl_word[SIG_MEM_EN] = 1;
					ctrl_word[SIG_B_LOAD] = 1;
				end
			endcase
		end
		5: begin
			case (opcode)
				OP_ADD: begin
					ctrl_word[SIG_ADDER_EN] = 1;
					ctrl_word[SIG_A_LOAD] = 1;
				end
				OP_SUB: begin
					ctrl_word[SIG_ADDER_SUB] = 1;
					ctrl_word[SIG_ADDER_EN] = 1;
					ctrl_word[SIG_A_LOAD] = 1;
				end
			endcase
		end
	endcase
end

assign out = ctrl_word;

endmodule