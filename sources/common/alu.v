//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 10/30/2023 07:00:28 PM
// Design Name: 
// Module Name: alu
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

module alu #(
    parameter DATA_WIDTH = 8
)(  
    input  wire                  clk,
    input  wire                  a_reset_n, // asynchronous reset
    input  wire [DATA_WIDTH-1:0] data_in,
    input  wire [3:0]            opcode,
    output wire                  acc_overflow,
    output wire                  acc_zero,
    output reg  [DATA_WIDTH-1:0] data_out
);

`include "sap1_header.vh"

// declare register variables
reg [DATA_WIDTH-1:0] registerA;
reg [DATA_WIDTH:0] accumulator;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) begin // asynchronous reset
        registerA   <= {DATA_WIDTH{1'b0}};
        accumulator <= {(DATA_WIDTH+1){1'b0}};
        data_out    <= {DATA_WIDTH{1'b0}};
    end else begin
        case (opcode)
            ALU_REGA: registerA <= data_in; // load the register
            ALU_ADD: accumulator <= accumulator + registerA; // addition
            ALU_SUB: accumulator <= accumulator - registerA; // subtraction
            ALU_AND: accumulator <= accumulator & registerA; // bitwise and
            ALU_OR: accumulator <= accumulator | registerA; // bitwise or
            ALU_XOR: accumulator <= accumulator ^ registerA; // bitwise xor
            ALU_LSHIFT: accumulator <= {accumulator[DATA_WIDTH-2:0],1'b0}; // left shift
            ALU_RSHIFT: accumulator <= {1'b0,accumulator[DATA_WIDTH-1:1]}; // right shift
            ALU_OUT: data_out <= accumulator[DATA_WIDTH-1:0]; // send output data
            ALU_RESET: accumulator <= {DATA_WIDTH{1'b0}}; // reset the accumulator
            default: accumulator <= accumulator; // do nothing
        endcase
        
    end
end

// assert control signal when accumulator is zero
assign acc_zero = (accumulator == {(DATA_WIDTH+1){1'b0}});

// assert overflow flag when MSB is set
assign acc_overflow = accumulator[DATA_WIDTH];

endmodule
