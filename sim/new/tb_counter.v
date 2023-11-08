//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/04/2023 06:02:40 PM
// Design Name: 
// Module Name: tb_counter
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

module tb_counter;

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam COUNT_WIDTH = 4;

// input
reg clk;
reg s_reset_n;
reg enable;
reg inc_en;
reg dec_en;
// output
wire [COUNT_WIDTH-1:0] counter;

counter #(.COUNT_WIDTH(COUNT_WIDTH)) dut(
    .clk        (clk),
    .s_reset_n  (s_reset_n),
    .enable     (enable),
    .inc_en     (inc_en),
    .dec_en     (dec_en),
    .counter    (counter)
);

always
    #5 clk = !clk;

//////////////////////////////////////////////////////////////////////////////////
// Test Bench
//////////////////////////////////////////////////////////////////////////////////
initial begin

    // default conditions
    clk = 1'b0;
    enable = 1'b0;
    inc_en = 1'b0;
    dec_en = 1'b0;
    
    s_reset_n = 1'b0; #10; // assert reset
    s_reset_n = 1'b1;

    enable = 1'b1; #40; // enable counter
    
    inc_en = 1'b1; #160;
    inc_en = 1'b0;
    
    dec_en = 1'b1; #160;
    dec_en = 1'b0;
    
end

endmodule
