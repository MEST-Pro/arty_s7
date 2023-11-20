//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/11/2023 10:59:34 AM
// Design Name: 
// Module Name: tb_bus_mux
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

module tb_bus_mux;

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam NUM_INPUT = 8;
localparam NUM_OUTPUT = 8;
localparam SEL_BIT = 3;
localparam DATA_WIDTH = 8;

integer i; // loop variable

// input
reg                              clk;
reg  [NUM_INPUT*DATA_WIDTH-1:0]  data_in;
reg  [SEL_BIT-1:0]               sel_in;
// output
wire [NUM_OUTPUT*DATA_WIDTH-1:0] data_out;

bus_mux #(.NUM_INPUT(NUM_INPUT),.NUM_OUTPUT(NUM_OUTPUT),.SEL_BIT(SEL_BIT),.DATA_WIDTH(DATA_WIDTH)) dut(
    .clk        (clk),
    .data_in    (data_in),
    .sel_in     (sel_in),
    .data_out   (data_out)
);

always
    #5 clk = !clk;

//////////////////////////////////////////////////////////////////////////////////
// Test Bench
//////////////////////////////////////////////////////////////////////////////////
initial begin

    clk = 1'b0;
    
    data_in[1*DATA_WIDTH-1:0*DATA_WIDTH] = 8'h00;
    data_in[2*DATA_WIDTH-1:1*DATA_WIDTH] = 8'hA1;
    data_in[3*DATA_WIDTH-1:2*DATA_WIDTH] = 8'hB2;
    data_in[4*DATA_WIDTH-1:3*DATA_WIDTH] = 8'hC3;
    data_in[5*DATA_WIDTH-1:4*DATA_WIDTH] = 8'hD4;
    data_in[6*DATA_WIDTH-1:5*DATA_WIDTH] = 8'hE5;
    data_in[7*DATA_WIDTH-1:6*DATA_WIDTH] = 8'hF6;
    data_in[8*DATA_WIDTH-1:7*DATA_WIDTH] = 8'h88;
    
    // step through all of the select settings
    for (i = 0; i < NUM_INPUT; i = i + 1) begin
        sel_in = i; #10;
    end
    
end

endmodule
