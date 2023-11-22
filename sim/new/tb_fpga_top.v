//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 02:03:27 PM
// Design Name: 
// Module Name: tb_fpga_top
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

module tb_fpga_top;

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

localparam ROM_DEPTH = 256;

integer i; // loop variable

// Oscillator
reg CLK100MHZ;
// Buttons
reg [3:0] BTN;
// Slide Switches
reg [3:0] SW;
// Tri-Color LED
wire [1:0] RLED;
wire [1:0] GLED;
wire [1:0] BLED;
// User LED
wire [3:0] LED;

fpga_top dut(
    // Oscillator
    .CLK100MHZ(CLK100MHZ),
    // Buttons
    .BTN(BTN),
    // Slide Switches
    .SW(SW),
    // Tri-Color LED
    .RLED(RLED),
    .GLED(GLED),
    .BLED(BLED),
    // User LED
    .LED(LED)
);

always
    #5 CLK100MHZ = !CLK100MHZ;

//////////////////////////////////////////////////////////////////////////////////
// Test Bench
//////////////////////////////////////////////////////////////////////////////////
initial begin

    //// Initialization ////

    // default state
    CLK100MHZ = 1'b0;
    BTN = 4'b0000;
    SW = 4'b0000;
    
    // power on reset
    BTN[0] = 1'b1; #100;
    BTN[0] = 1'b0;
    
    // clock & reset
    while (dut.pll_lock == 1'b0) #10; // wait for PLL lock
    while (dut.s_reset == 1'b1) #10; // wait for reset to release

    //// Load Program ////
    
    BTN[1] = 1'b1; #10; // start program transfer

end

endmodule
