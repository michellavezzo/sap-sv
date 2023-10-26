module clock(
	input logic hlt,
	input logic clk_in,
	output logic clk_out
);
// Em caso de parada, Clock será setado para 0
assign clk_out = (hlt) ? 1'b0 : clk_in;

endmodule
