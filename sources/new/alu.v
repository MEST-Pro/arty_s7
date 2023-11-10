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
    output wire [DATA_WIDTH-1:0] data_out
);

// define alu instructions
localparam [3:0] ALU_REGA   = 4'h1;
localparam [3:0] ALU_ADD    = 4'h2;
localparam [3:0] ALU_SUB    = 4'h3;
localparam [3:0] ALU_AND    = 4'h4;
localparam [3:0] ALU_OR     = 4'h5;
localparam [3:0] ALU_XOR    = 4'h6;
localparam [3:0] ALU_LSHIFT = 4'h7;
localparam [3:0] ALU_RSHIFT = 4'h8;
localparam [3:0] ALU_OUT    = 4'h9;
localparam [3:0] ALU_RESET  = 4'hA;

// declare register variables
reg [DATA_WIDTH-1:0] registerA;
reg [DATA_WIDTH-1:0] accumulator;
reg [DATA_WIDTH-1:0] outputBus;

always@(posedge clk or negedge a_reset_n) begin
    if (!a_reset_n) begin // asynchronous reset
        registerA   <= {DATA_WIDTH{1'b0}};
        accumulator <= {DATA_WIDTH{1'b0}};
        outputBus   <= {DATA_WIDTH{1'b0}};
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
            ALU_OUT: outputBus <= accumulator; // send output data
            ALU_RESET: accumulator <= {DATA_WIDTH{1'b0}}; // reset the accumulator
            default: accumulator <= accumulator; // do nothing
        endcase
    end
end

assign data_out = outputBus;

endmodule
