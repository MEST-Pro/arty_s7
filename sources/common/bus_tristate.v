//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/11/2023 11:37:56 AM
// Design Name: 
// Module Name: bus_tristate
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

module bus_tristate #(
    parameter NUM_INPUT = 8,
    parameter NUM_OUTPUT = 8,
    parameter SEL_BIT = 3,
    parameter DATA_WIDTH = 8
)(  
    input  wire                             clk,
    input  wire [NUM_INPUT*DATA_WIDTH-1:0]  data_in,
    input  wire [SEL_BIT-1:0]               sel_in,
    output wire [NUM_OUTPUT*DATA_WIDTH-1:0] data_out
);

wire [DATA_WIDTH-1:0] bus; // bus net

// generate variable
genvar i;
genvar j;

generate
    for (i = 0; i < NUM_INPUT; i = i + 1) begin
        // tristate buffer on each input driver (only one active)
        assign bus = (sel_in == i) ? data_in[i*DATA_WIDTH+:DATA_WIDTH] : 'bZ;
    end
endgenerate

generate
    for (j = 0; j < NUM_OUTPUT; j = j + 1) begin
        // all outputs driven by bus
        assign data_out[j*DATA_WIDTH+:DATA_WIDTH] = bus;
    end
endgenerate


endmodule
