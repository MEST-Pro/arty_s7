//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/06/2023 07:32:53 PM
// Design Name: 
// Module Name: clk_led
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

module clk_led #(
    parameter COUNT_WIDTH = 32
)(  
    input  wire clk,
    input  wire s_reset, // synchronous reset
    output wire led_out
);

// count for 1 second
localparam [COUNT_WIDTH-1:0] COUNT_LIMIT = 32'h05F5E0FF;

reg led_state;
reg [COUNT_WIDTH-1:0] counter;

always@(posedge clk) begin
    
    //// Heartbeat Counter ////
    
    if (s_reset) // synchronous reset
        counter <= {COUNT_WIDTH{1'b0}};
    else if (counter == COUNT_LIMIT) // count limit reached
        counter <= {COUNT_WIDTH{1'b0}};
    else // increment counter
        counter <= counter + 1'b1; 
    
    //// LED Register ////
    
    if (s_reset) // synchronous reset
        led_state <= 1'b0;
    else if (counter == COUNT_LIMIT) // count limit reached
        led_state <= ~led_state; // toggle the LED
    
end

assign led_out = led_state;

endmodule
