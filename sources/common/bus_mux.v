//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/11/2023 10:46:52 AM
// Design Name: 
// Module Name: bus_mux
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

module bus_mux #(
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

// declare synthesizable loop variables
integer i;
integer j;

// declare register variables
reg [SEL_BIT-1:0]    sel_reg;
reg [DATA_WIDTH-1:0] data_in_reg [0:NUM_INPUT-1];
reg [DATA_WIDTH-1:0] data_out_reg [0:NUM_OUTPUT-1];
reg [DATA_WIDTH-1:0] data_sel_reg;

always@(posedge clk) begin
    
    // input buffer pipeline
    for (i = 0; i < NUM_INPUT; i = i + 1) begin
        data_in_reg[i] <= data_in[i*DATA_WIDTH+:DATA_WIDTH];
    end
    
    // pipeline the bus select
    sel_reg <= sel_in;
    
    // mux select pipeline
    data_sel_reg <= data_in_reg[sel_reg];
    
    // output buffer pipeline
    for (j = 0; j < NUM_OUTPUT; j = j + 1) begin
        data_out_reg[j] <= data_sel_reg;    
    end

end

genvar k; // generate variable

generate
    for (k = 0; k < NUM_OUTPUT; k = k + 1) begin
        // map output buffer to output data vector
        assign data_out[k*DATA_WIDTH+:DATA_WIDTH] = data_out_reg[k];
    end
endgenerate

endmodule
