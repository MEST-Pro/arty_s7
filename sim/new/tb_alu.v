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

`include "sap1_header.vh"

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam DATA_WIDTH = 8;

// input
reg                   clk;
reg                   a_reset_n;
reg  [DATA_WIDTH-1:0] data_in;
reg  [3:0]            opcode;
// output
wire                  acc_overflow;
wire                  acc_zero;
wire [DATA_WIDTH-1:0] data_out;

alu #(.DATA_WIDTH(DATA_WIDTH)) dut(
    .clk            (clk),
    .a_reset_n      (a_reset_n),
    .data_in        (data_in),
    .opcode         (opcode),
    .acc_overflow   (acc_overflow),
    .acc_zero       (acc_zero),
    .data_out       (data_out)
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
    data_in = 8'h0F; opcode = ALU_REGA; #10; // load register A
    opcode = ALU_SUB; #10; // subtraction
    opcode = ALU_OUT; #10; // output the result "0x00"
    
    opcode = ALU_RESET; #10 // reset the accumulator
    
    //// Overflow ////
    
    data_in = 8'h0F; opcode = ALU_REGA; #10; // load register A
    opcode = ALU_ADD; # 10 // addition
    data_in = 8'h10; opcode = ALU_REGA; #10; // load register A
    opcode = ALU_SUB; #10; // subtraction
    opcode = ALU_OUT; // output the result "0xFF"
    
end

endmodule
