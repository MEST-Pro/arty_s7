`timescale 1ns / 1ps
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

module tb_fpga_top;

//////////////////////////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////////////////////////

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
    // Buttons
    .BTN    (BTN),
    // Slide Switches
    .SW     (SW),
    // Tri-Color LED
    .RLED   (RLED),
    .GLED   (GLED),
    .BLED   (BLED),
    // User LED
    .LED    (LED)
);

//////////////////////////////////////////////////////////////////////////////////
// Test Bench
//////////////////////////////////////////////////////////////////////////////////
initial begin

    $monitor("SW = %b | LED = %b",SW,LED[1:0]);
    
    SW = 4'b0000; #5;
    SW = 4'b0001; #5;
    SW = 4'b0010; #5;
    SW = 4'b0100; #5;
    SW = 4'b1000; #5;
    SW = 4'b0011; #5;
    SW = 4'b1100; #5;
    SW = 4'b1111; #5;

end

endmodule
