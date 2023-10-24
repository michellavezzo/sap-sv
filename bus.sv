module bus(
    input       ir_en,
    input [7:0] ir_out,
    input       adder_en,
    input [7:0] adder_out,
    input       a_en,
    input [7:0] a_out,
    input       mem_en,
    input [7:0] mem_out,
    input       pc_en,
    input [7:0] pc_out,
    output reg [7:0] bus
);

always @(*) begin
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
