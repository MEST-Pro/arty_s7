//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/09/2023 07:15:42 PM
// Design Name: 
// Module Name: tb_mac
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

module tb_mac;

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam DATA_WIDTH = 8;

// input
reg                    clk;
reg                    a_reset;
reg [DATA_WIDTH-1:0]   op_a;
reg [DATA_WIDTH-1:0]   op_b;
// output
wire [2*DATA_WIDTH-1:0] result;

mac #(.DATA_WIDTH(DATA_WIDTH)) dut(
    .clk        (clk),
    .a_reset    (a_reset),
    .op_a       (op_a),
    .op_b       (op_b),
    .result     (result)
);

always
    #5 clk = !clk;

//////////////////////////////////////////////////////////////////////////////////
// Test Bench
//////////////////////////////////////////////////////////////////////////////////
initial begin

    clk = 1'b0;
    
    a_reset = 1'b1; #10; // assert reset
    a_reset = 1'b0;
    
    op_a = 8'h0F; op_b = 8'h1A; #10; // load register A,B : 15 x 26 = 390 
    op_a = 8'h26; op_b = 8'h05; #10; // load register A,B : 38 x 5 = 190
    op_a = 8'h03; op_b = 8'h11; #10; // load register A,B : 3 x 17 = 51
    
    // result : 631 = 0x0277
    
    op_a = 8'h00; op_b = 8'h00;
    
end

endmodule
