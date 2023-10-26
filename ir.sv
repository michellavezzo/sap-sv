// Instruction Register
// Before an instruction can be interpreted and acted upon, 
// it needs to be loaded from memory into a module that can separate the opcode from the data.
// That’s the job of the Instruction Register (IR).

//	O conteúdo de RI é dividido em dois nibbles
//	Nibble superior
//		◻ Vai para o bloco controlador/sequencializador
//	Nibble inferior
//		◻ Vai para o barramento 

module ir(
	input logic clk,
	input logic rst,
	input logic load,
	input logic [7:0] bus,
	output logic [7:0] out
);

logic [7:0] ir;

always_ff @(posedge clk or posedge rst) begin
	if (rst) begin
		ir <= 8'b0;
	end else if (load) begin
		ir <= bus;
	end
end

assign out = ir;

endmodule
