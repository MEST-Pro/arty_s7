//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 10/30/2023 07:32:07 PM
// Design Name: 
// Module Name: tb_alu
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

module tb_alu;

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam DATA_WIDTH = 8;

localparam [3:0] ALU_REGA  = 4'h1;
localparam [3:0] ALU_ADD   = 4'h2;
localparam [3:0] ALU_SUB   = 4'h3;
localparam [3:0] ALU_AND   = 4'h4;
localparam [3:0] ALU_OR    = 4'h5;
localparam [3:0] ALU_XOR   = 4'h6;
localparam [3:0] ALU_OUT   = 4'h7;
localparam [3:0] ALU_RESET = 4'h8;

// input
reg                   clk;
reg                   a_reset_n;
reg  [DATA_WIDTH-1:0] data_in;
reg  [3:0]            opcode;
// output
wire [DATA_WIDTH-1:0] data_out;

alu #(.DATA_WIDTH(DATA_WIDTH)) dut(
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

    opcode = ALU_RESET; #10; // reset the accumulator
    
    data_in = 8'h0F; opcode = ALU_REGA; #10; // load register A
    opcode = ALU_ADD; #10; // addition
    data_in = 8'hAA; opcode = ALU_REGA; #10; // load register A
    opcode = ALU_AND; #10; // bitwise and
    data_in = 8'h05; opcode = ALU_REGA; #10; // load register A
    opcode = ALU_OR; #10; // bitwise or
    data_in = 8'h0F; opcode = ALU_REGA; #10; // load regsiter A
    opcode = ALU_SUB; #10; // subtraction
    opcode = ALU_OUT; #10; // output the result
    
end

endmodule
