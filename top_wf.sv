module top_wf(
    input logic clk_in,
    input logic hlt_in,
    input logic rst,
    output logic [7:0] bus,
    output logic pc_inc, pc_en, mar_load, mem_en, a_load, a_en, b_load, adder_sub, adder_en, ir_load, ir_en,
    output logic [7:0] pc_out, mem_out, a_out, b_out, adder_out, ir_out
);

    // Internal Logic Declarations
	logic local_hlt; 
    // Bus logic
    always_comb begin
        casez ({pc_en, mem_en, ir_en, a_en, adder_en})
            5'b00001: bus = adder_out;
            5'b00010: bus = a_out;
            5'b00100: bus = ir_out;
            5'b01000: bus = mem_out;
            5'b10000: bus = pc_out;
            default: bus = 8'b0;
        endcase
    end
	logic clk;
    // Clock
    clock clk_inst (
        .hlt(local_hlt),
        .clk_in(clk_in),
        .clk_out(clk) 
    );

    // PC
    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .inc(pc_inc),
        .out(pc_out)
    );

    // Memory
    memory mem_inst (
        .clk(clk),
        .rst(rst),
        .load(mar_load),
        .bus(bus),
        .out(mem_out)
    );

    // Register A
    reg_a reg_a_inst (
        .clk(clk),
        .rst(rst),
        .load(a_load),
        .bus(bus),
        .out(a_out)
    );

    // Register B
    reg_b reg_b_inst (
        .clk(clk),
        .rst(rst),
        .load(b_load),
        .bus(bus),
        .out(b_out)
    );

    // Adder
    adder adder_inst (
        .a(a_out),
        .b(b_out),
        .sub(adder_sub),
        .out(adder_out)
    );

    // Instruction Register
    ir ir_inst (
        .clk(clk),
        .rst(rst),
        .load(ir_load),
        .bus(bus),
        .out(ir_out)
    );
	
	assign local_hlt = hlt_in | controller_hlt; // local_hlt will be true if either hlt_in or controller_hlt is true
    // Controller
    controller controller_inst (
        .clk(clk),
        .rst(rst),
        .opcode(ir_out[7:4]),
        .out({controller_hlt, pc_inc, pc_en, mar_load, mem_en, ir_load, ir_en, a_load, a_en, b_load, adder_sub, adder_en})
    );
//	 assign local_hlt = hlt_in;

endmodule
