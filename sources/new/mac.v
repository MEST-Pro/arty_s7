//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/09/2023 06:22:37 PM
// Design Name: 
// Module Name: mac
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

module mac #(
    parameter DATA_WIDTH = 8
)(
    input wire                    clk,
    input wire                    a_reset, // asynchronous reset
	input wire [DATA_WIDTH-1:0]   op_a,
	input wire [DATA_WIDTH-1:0]   op_b,
	output reg [2*DATA_WIDTH-1:0] result
);
    
    // declare register variables
	reg [DATA_WIDTH-1:0] op_a_reg;
	reg [DATA_WIDTH-1:0] op_b_reg;
	
	// declare multipler net
	wire [2*DATA_WIDTH-1:0] mult;

	assign mult = op_a_reg * op_b_reg; // multiplier

	always @ (posedge clk or posedge a_reset) begin
		if (a_reset) begin // asynchronous reset
			op_a_reg <= 0;
			op_b_reg <= 0;
			result <= 0; // reset the accumulator
		end else begin
			op_a_reg <= op_a;
			op_b_reg <= op_b;
			result <= result + mult; // accumulate the multiplier result
		end
	end

endmodule