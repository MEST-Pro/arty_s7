//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nick Stasi
// 
// Create Date: 12/23/2023 11:05:28 PM
// Design Name: 
// Module Name: asic_top
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

module asic_top (  
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


mest_pro_top #(.ASIC(1)) mest_pro(
    // Local Oscillator
    .CLK100MHZ   (CLK100MHZ),
    // Buttons
    .BTN         (BTN),
    // Slide Switches
    .SW          (SW),
    // Tri-Color LED
    .RLED        (RLED),
    .GLED        (GLED),
    .BLED        (BLED),
    // User LED
    .LED         (LED)
);

endmodule
