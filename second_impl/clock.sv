module clock(
	input logic hlt,
	input logic clk_in,
	output logic clk_out
);

assign clk_out = (hlt) ? 1'b0 : clk_in;

endmodule
