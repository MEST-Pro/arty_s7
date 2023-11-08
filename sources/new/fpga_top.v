//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 10/25/2023 07:23:05 PM
// Design Name:
// Module Name: fpga_top
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

module fpga_top(
    // Local Oscillator
    input CLK100MHZ,
    // Buttons
    input [3:0] BTN,
    // Slide Switches
    input [3:0] SW,
    // Tri-Color LED
    output [1:0] RLED,
    output [1:0] GLED,
    output [1:0] BLED,
    // User LED
    output [3:0] LED
);

//// Phase Locked Loop ////

wire clk100MHz;
wire pll_lock;
wire pll_reset;

assign pll_reset = BTN[0];

fpga_pll fpga_pll_inst (
    .clk_in     (CLK100MHZ), // input clock
    .reset      (pll_reset), // input reset
    .locked     (pll_lock),  // output locked
    .clk100MHz  (clk100MHz)  // output clk100MHz
);

//// Reset Synchronzier ////

wire rst100MHz;
wire a_reset;

// send reset pulse if pll unlocked or external reset asserted
assign a_reset = ~pll_lock || pll_reset;

rst_sync rst_sync_100MHz (  
    .clk        (clk100MHz),
    .a_reset    (a_reset),
    .s_reset    (rst100MHz)
);

//// Heartbeat Monitor ////

// drive LED0 with 100MHZ heartbeat
clk_led clk_led_inst (  
    .clk        (clk100MHz),
    .s_reset    (rst100MHz),
    .led_out    (LED[0])
);

endmodule