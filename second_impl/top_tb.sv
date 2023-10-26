module top_tb(
output[11:0] out
);

logic clk;
logic hlt;
logic rst;

logic pc_inc;
logic pc_en;
logic [7:0] pc_out;

logic mar_load;
logic mem_en;
logic [7:0] mem_out;

logic a_load;
logic a_en;
logic [7:0] a_out;

logic b_load;
logic [7:0] b_out;

logic adder_sub;
logic adder_en;
logic [7:0] adder_out;

logic ir_load;
logic ir_en;
logic [7:0] ir_out;

logic clk_in = 0;
int i;

initial begin
	$dumpfile("top_tb.vcd");
	$dumpvars(0, top_tb);
	rst = 1;
	#1 rst = 0;
end

wire [4:0] bus_en = {pc_en, mem_en, ir_en, a_en, adder_en};
logic [7:0] bus;

always_comb begin
	case (bus_en)
		5'b00001: bus = adder_out;
		5'b00010: bus = a_out;
		5'b00100: bus = ir_out;
		5'b01000: bus = mem_out;
		5'b10000: bus = pc_out;
		default: bus = 8'b0;
	endcase
end

initial begin
	for (i = 0; i < 128; i++) begin
		#1 clk_in = ~clk_in;
	end
end

clock clock_inst(
	.hlt(hlt),
	.clk_in(clk_in),
	.clk_out(clk)
);


pc pc_inst(
	.clk(clk),
	.rst(rst),
	.inc(pc_inc),
	.out(pc_out)
);


memory mem_inst(
	.clk(clk),
	.rst(rst),
	.load(mar_load),
	.bus(bus),
	.out(mem_out)
);

reg_a reg_a_inst(
	.clk(clk),
	.rst(rst),
	.load(a_load),
	.bus(bus),
	.out(a_out)
);

reg_b reg_b_inst(
	.clk(clk),
	.rst(rst),
	.load(b_load),
	.bus(bus),
	.out(b_out)
);


adder adder_inst(
	.a(a_out),
	.b(b_out),
	.sub(adder_sub),
	.out(adder_out)
);


ir ir_inst(
	.clk(clk),
	.rst(rst),
	.load(ir_load),
	.bus(bus),
	.out(ir_out)
);

controller controller_inst(
	.clk(clk),
	.rst(rst),
	.opcode(ir_out[7:4]),
	.out(
	{
		hlt,
		pc_inc,
		pc_en,
		mar_load,
		mem_en,
		ir_load,
		ir_en,
		a_load,
		a_en,
		b_load,
		adder_sub,
		adder_en
	})
);

endmodule
