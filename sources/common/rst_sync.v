//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/06/2023 07:45:29 PM
// Design Name: 
// Module Name: rst_sync
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

module rst_sync #(
    parameter SYNC_CLOCK = 4
)(  
    input  wire clk,
    input  wire a_reset,
    output wire s_reset
);

reg [SYNC_CLOCK-1:0] shift_reg;

always@(posedge clk or posedge a_reset) begin
    if (a_reset)
        shift_reg <= {SYNC_CLOCK{1'b1}};
    else
        shift_reg <= {shift_reg[SYNC_CLOCK-2:0],1'b0};
end

assign s_reset = shift_reg[SYNC_CLOCK-1];

endmodule
