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
    output wire                   out_of_range,
    output wire [COUNT_WIDTH-1:0] counter
);

reg [COUNT_WIDTH:0] counter_reg;

always @ (posedge clk or negedge a_reset_n) begin
    
    if (a_reset_n == 1'b0) // asynchronous reset
       counter_reg <= {(COUNT_WIDTH+1){1'b0}};
    else if (reset == 1'b1) // processor reset
       counter_reg <= {(COUNT_WIDTH+1){1'b0}};
    else if (load == 1'b1) // load the counter
       counter_reg <= {1'b0,load_data};
    else if (increment == 1'b1) // increment the counter
       counter_reg <= counter_reg + 1'b1;
    else // if counting is disabled
       counter_reg <= counter_reg;

end

// out of range if MSB is set
assign out_of_range = counter_reg[COUNT_WIDTH];

// LSB are the count
assign counter = counter_reg[COUNT_WIDTH-1:0];

endmodule
