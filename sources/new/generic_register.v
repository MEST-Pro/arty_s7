//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2023 02:03:39 PM
// Design Name: 
// Module Name: generic_register
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

module generic_register #(
    parameter REG_WIDTH = 8
)(  
    input  wire                  clk,
    input  wire                  a_reset_n, // asynchronous reset
    input  wire                  enable,
    input  wire [REG_WIDTH-1:0]  data_in,
    output wire                  valid,
    output wire [REG_WIDTH-1:0]  data_out
);

// define register variable
reg [REG_WIDTH-1:0] reg_data;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0)
        reg_data <= {REG_WIDTH{1'b0}};
    else if (enable == 1'b1)
        reg_data <= data_in;
end

// output register contents
assign data_out = reg_data;

reg enable_reg;

always@(posedge clk) begin
    enable_reg <= enable;
end

assign valid = enable_reg;

endmodule
