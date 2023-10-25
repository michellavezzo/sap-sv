module pc(
	input logic clk,
	input logic rst,
	input logic inc,
	output logic [7:0] out
);

logic [3:0] pc_value;  // Renamed from pc to pc_value for clarity

always_ff @(posedge clk or posedge rst) begin
	if (rst) begin
		pc_value <= 4'b0;
	end else if (inc) begin
		pc_value <= pc_value + 1;
	end
end

assign out = pc_value;

endmodule
