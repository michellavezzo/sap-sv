module reg_b(
	input logic clk,
	input logic rst,
	input logic load,
	input logic [7:0] bus,
	output logic [7:0] out
);

logic [7:0] reg_value;  // Renamed from reg_b to reg_value

always_ff @(posedge clk or posedge rst) begin
	if (rst) begin
		reg_value <= 8'b0;
	end else if (load) begin
		reg_value <= bus;
	end
end

assign out = reg_value;

endmodule
