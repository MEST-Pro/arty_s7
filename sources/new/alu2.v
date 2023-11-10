//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/09/2023 06:33:22 PM
// Design Name: 
// Module Name: alu2
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

module alu2 #(
    parameter DATA_WIDTH = 8
)(  
    input  wire                  clk,
    input  wire                  a_reset_n, // asynchronous reset
    input  wire [DATA_WIDTH-1:0] data_in,
    input  wire [3:0]            opcode,
    output wire [DATA_WIDTH-1:0] data_out
);

// define alu instructions
localparam [3:0] ALU2_REGA  = 4'h1;
localparam [3:0] ALU2_REGB  = 4'h2;
localparam [3:0] ALU2_MULT  = 4'h3;
localparam [3:0] ALU2_ACC   = 4'h4;
localparam [3:0] ALU2_MSB   = 4'h5;
localparam [3:0] ALU2_LSB   = 4'h6;
localparam [3:0] ALU2_RESET = 4'h7;

// declare register variables
reg [DATA_WIDTH-1:0] registerA;
reg [DATA_WIDTH-1:0] registerB;
reg [2*DATA_WIDTH-1:0] registerC; // store the result of the multiplication
reg [2*DATA_WIDTH-1:0] accumulator;
reg [DATA_WIDTH-1:0] outputBus;

always@(posedge clk or negedge a_reset_n) begin
    if (!a_reset_n) begin // asynchronous reset
        registerA   <= {DATA_WIDTH{1'b0}};
        registerB   <= {DATA_WIDTH{1'b0}};
        registerC   <= {2*DATA_WIDTH{1'b0}};
        accumulator <= {2*DATA_WIDTH{1'b0}};
        outputBus   <= {DATA_WIDTH{1'b0}};
    end else begin
        case (opcode)
            ALU2_REGA: registerA <= data_in; // load register A
            ALU2_REGB: registerB <= data_in; // load register B
            ALU2_MULT: registerC <= registerA * registerB; // multiply
            ALU2_ACC: accumulator <= accumulator + registerC; // accumulate
            ALU2_MSB: outputBus <= accumulator[2*DATA_WIDTH-1:1*DATA_WIDTH]; // output MSB
            ALU2_LSB: outputBus <= accumulator[1*DATA_WIDTH-1:0*DATA_WIDTH]; // output LSB
            ALU2_RESET: outputBus <= {2*DATA_WIDTH{1'b0}}; // send output data
            default: accumulator <= accumulator; // do nothing
        endcase
    end
end

assign data_out = outputBus;

endmodule
