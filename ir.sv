// Instruction Register
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
