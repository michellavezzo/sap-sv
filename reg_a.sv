module reg_a(
	input logic clk,
	input logic rst,
	input logic load,
	input logic [7:0] bus,
	output logic [7:0] out
);

logic [7:0] reg_value_a;  // Renamed from reg_a to reg_value_a

always_ff @(posedge clk or posedge rst) begin
	if (rst) begin
		reg_value_a <= 8'b0;
	end else if (load) begin
		reg_value_a <= bus;
	end
end

assign out = reg_value_a;

endmodule
