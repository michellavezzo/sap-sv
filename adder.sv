module adder(
	input logic [7:0] a,
	input logic [7:0] b,
	input logic sub,
	output logic [7:0] out
);

assign out = (sub) ? a-b : a+b;

endmodule
