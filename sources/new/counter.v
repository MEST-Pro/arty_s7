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
    input  wire clk,
    input  wire s_reset_n, // synchronous reset
    input  wire enable, 
    input  wire inc_en,
    input  wire dec_en,
    output reg [COUNT_WIDTH-1:0] counter
);

always @ (posedge clk)
    
    if (s_reset_n == 1'b0) begin // if synchronous reset is asserted
       counter <= {COUNT_WIDTH{1'b0}}; 
    end else if (enable == 1'b1 && inc_en == 1'b1) begin // if counter is enabled and up count is asserted
       counter <= counter + 1'b1;
    end else if (enable == 1'b1 && dec_en == 1'b1) begin // if counter is enable and down count is asserted
       counter <= counter - 1'b1;
    end else begin // if counting is disabled
       counter <= counter;
    end

endmodule
