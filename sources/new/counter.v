//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/04/2023 05:36:11 PM
// Design Name: 
// Module Name: counter
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

module counter #(
    parameter COUNT_WIDTH = 8
)(  
    input  wire                   clk,
    input  wire                   a_reset_n, // asynchronous reset
    input  wire                   reset,
    input  wire                   load, 
    input  wire [COUNT_WIDTH-1:0] load_data,
    input  wire                   increment,
    output reg  [COUNT_WIDTH-1:0] counter
);

always @ (posedge clk or negedge a_reset_n)
    
    if (a_reset_n == 1'b0) // asynchronous reset
       counter <= {COUNT_WIDTH{1'b0}};
    else if (reset == 1'b1) // processor reset
        counter <= {COUNT_WIDTH{1'b0}};
    else if (load == 1'b1) // load the counter
       counter <= load_data;
    else if (increment == 1'b1) // increment the counter
       counter <= counter + 1'b1;
    else // if counting is disabled
       counter <= counter;

endmodule
