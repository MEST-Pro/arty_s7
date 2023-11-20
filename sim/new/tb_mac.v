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

`include "sap1_header.vh"

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam DATA_WIDTH = 8;

// input
reg                  clk;
reg                  a_reset_n;
reg [DATA_WIDTH-1:0] data_in;
reg [3:0]            opcode;
// output
wire                  acc_overflow;
wire [DATA_WIDTH-1:0] data_out;

mac #(.DATA_WIDTH(DATA_WIDTH)) dut(
    .clk            (clk),
    .a_reset_n      (a_reset_n),
    .data_in        (data_in),
    .opcode         (opcode),
    .acc_overflow   (acc_overflow),
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

    opcode = MAC_RESET; #10; // reset the accumulator
    
    data_in = 8'h0F; opcode = MAC_REGA; #10; // load register A : 15
    data_in = 8'h1A; opcode = MAC_REGB; #10; // load register B : 26
    opcode = MAC_MULT; #10; // multiply : 15 x 26 = 390 
    opcode = MAC_ACC; #10; // accumulate : 0 + 390 = 390
    
    data_in = 8'h26; opcode = MAC_REGA; #10; // load register A : 38
    data_in = 8'h05; opcode = MAC_REGB; #10; // load register B : 5
    opcode = MAC_MULT; #10; // multiply : 38 x 5 = 190
    opcode = MAC_ACC; #10; // accumulate : 390 + 190 = 580
    
    data_in = 8'h03; opcode = MAC_REGA; #10; // load register A : 3
    data_in = 8'h11; opcode = MAC_REGB; #10; // load register B : 17
    opcode = MAC_MULT; #10; // multiply : 3 x 17 = 51
    opcode = MAC_ACC; #10; // accumulate : 580 + 51 = 631
    
    // 631 = 0x0277
    opcode = MAC_MSW; #10; // output the MSB of the result : 0x02
    opcode = MAC_LSW; #10; // output the LSB of the result : 0x77
    
    //// Overflow ////
    
    opcode = MAC_RESET; #10; // reset the accumulator
    
    data_in = 8'hFF; opcode = MAC_REGA; #10; // load register A : 255
    data_in = 8'hFE; opcode = MAC_REGB; #10; // load register B : 254
    opcode = MAC_MULT; #10; // multiply : 255 x 254 = 64770 
    opcode = MAC_ACC; #10; // accumulate : 0 + 64770 = 64770
    
    data_in = 8'hFD; opcode = MAC_REGA; #10; // load register A : 253
    data_in = 8'hFC; opcode = MAC_REGB; #10; // load register B : 252
    opcode = MAC_MULT; #10; // multiply : 253 x 252 = 63756 
    opcode = MAC_ACC; #10; // accumulate : 64770 + 63756 = 128526
    
    // 128526 = 0x1F60E
    opcode = MAC_MSW; #10; // output the MSB of the result : 0xF6
    opcode = MAC_LSW; #10; // output the LSB of the result : 0x0E
    
end

endmodule
