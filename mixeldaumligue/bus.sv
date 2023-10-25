module bus(
    input logic        ir_en,
    output logic [7:0] ir_out,
    input logic        adder_en,
    output logic [7:0] adder_out,
    input logic        a_en,
    output logic [7:0] a_out,
    input logic        mem_en,
    output logic [7:0] mem_out,
    input logic        pc_en,
    output logic [7:0] pc_out,
    output logic [7:0] bus
);

always_comb begin
    if (ir_en) begin
        bus = ir_out;
    end else if (adder_en) begin
        bus = adder_out;
    end else if (a_en) begin
        bus = a_out;
    end else if (mem_en) begin
        bus = mem_out;
    end else if (pc_en) begin
        bus = pc_out;
    end else begin
        bus = 8'b0;
    end
end

endmodule
