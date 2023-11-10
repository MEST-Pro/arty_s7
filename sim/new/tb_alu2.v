//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/09/2023 06:46:25 PM
// Design Name: 
// Module Name: tb_alu2
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

module tb_alu2;

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam DATA_WIDTH = 8;

localparam [3:0] ALU2_REGA  = 4'h1;
localparam [3:0] ALU2_REGB  = 4'h2;
localparam [3:0] ALU2_MULT  = 4'h3;
localparam [3:0] ALU2_ACC   = 4'h4;
localparam [3:0] ALU2_MSB   = 4'h5;
localparam [3:0] ALU2_LSB   = 4'h6;
localparam [3:0] ALU2_RESET = 4'h7;

// input
reg                  clk;
reg                  a_reset_n;
reg [DATA_WIDTH-1:0] data_in;
reg [3:0]            opcode;
// output
wire [DATA_WIDTH-1:0] data_out;

alu2 #(.DATA_WIDTH(DATA_WIDTH)) dut(
    .clk        (clk),
    .a_reset_n  (a_reset_n),
    .data_in    (data_in),
    .opcode     (opcode),
    .data_out   (data_out)
);

always
    #5 clk = !clk;

//////////////////////////////////////////////////////////////////////////////////
// Test Bench
//////////////////////////////////////////////////////////////////////////////////
initial begin

    clk = 1'b0;
    
    a_reset_n = 1'b0; #10; // assert reset
    a_reset_n = 1'b1;

    opcode = ALU2_RESET; #10; // reset the accumulator
    
    data_in = 8'h0F; opcode = ALU2_REGA; #10; // load register A : 15
    data_in = 8'h1A; opcode = ALU2_REGB; #10; // load register B : 26
    opcode = ALU2_MULT; #10; // multiply : 15 x 26 = 390 
    opcode = ALU2_ACC; #10; // accumulate : 0 + 390 = 390
    
    data_in = 8'h26; opcode = ALU2_REGA; #10; // load register A : 38
    data_in = 8'h05; opcode = ALU2_REGB; #10; // load register B : 5
    opcode = ALU2_MULT; #10; // multiply : 38 x 5 = 190
    opcode = ALU2_ACC; #10; // accumulate : 390 + 190 = 580
    
    data_in = 8'h03; opcode = ALU2_REGA; #10; // load register A : 3
    data_in = 8'h11; opcode = ALU2_REGB; #10; // load register B : 17
    opcode = ALU2_MULT; #10; // multiply : 3 x 17 = 51
    opcode = ALU2_ACC; #10; // accumulate : 580 + 51 = 631
    
    // 631 = 0x0277
    opcode = ALU2_MSB; #10; // output the MSB of the result : 0x02
    opcode = ALU2_LSB; #10; // output the LSB of the result : 0x77
    
end

endmodule
