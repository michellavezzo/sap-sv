module memory(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [7:0] bus,
    output logic [7:0] out
);

logic [3:0] mar;
logic [7:0] ram[0:15];

initial begin
    ram[0]  = 8'h00;
    ram[1]  = 8'h01;
    ram[2]  = 8'h02;
    ram[3]  = 8'h03;
    ram[4]  = 8'h04;
    ram[5]  = 8'h05;
    ram[6]  = 8'h06;
    ram[7]  = 8'h07;
    ram[8]  = 8'h08;
    ram[9]  = 8'h09;
    ram[10] = 8'h0A;
    ram[11] = 8'h0B;
    ram[12] = 8'h0C;
    ram[13] = 8'h0D;
    ram[14] = 8'h0E;
    ram[15] = 8'h0F;
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        mar <= 4'b0;
    end else if (load) begin
        mar <= bus[3:0];
    end
end

assign out = ram[mar];

endmodule
