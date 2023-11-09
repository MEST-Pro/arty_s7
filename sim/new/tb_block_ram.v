//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/08/2023 07:33:33 PM
// Design Name: 
// Module Name: tb_block_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module tb_block_ram;

// define ram parameter
localparam ADDR_WIDTH = 4;
localparam RAM_WIDTH = 8;
localparam RAM_DEPTH = 16;

integer i; // loop variable

// input
reg                   clk;
reg                   wen;
reg  [ADDR_WIDTH-1:0] addr;
reg  [RAM_WIDTH-1:0]  wdata;
// output
wire [RAM_WIDTH-1:0]  rdata;

block_ram #(.ADDR_WIDTH(ADDR_WIDTH),.RAM_WIDTH(RAM_WIDTH),.RAM_DEPTH(RAM_DEPTH)) dut(
    .clk    (clk),
    .wen    (wen),
    .addr   (addr),
    .wdata  (wdata),
    .rdata  (rdata)
);

always
    #5 clk = !clk;

//////////////////////////////////////////////////////////////////////////////////
// Test Bench
//////////////////////////////////////////////////////////////////////////////////
initial begin

    clk = 1'b0;

    // write data to the ram
    for (i = 0; i < RAM_DEPTH; i = i + 1) begin
        wen <= 1'b1; addr <= i; wdata <= $urandom; #10;
    end
    
    // read data from the ram
    for (i = 0; i < RAM_DEPTH; i = i + 1) begin
        wen <= 1'b0; addr <= i; #10;
    end
    
end

endmodule
