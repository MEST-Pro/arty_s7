//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/09/2023 06:33:22 PM
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
    input  wire                  clk,
    input  wire                  a_reset_n, // asynchronous reset
    input  wire [DATA_WIDTH-1:0] data_in,
    input  wire [3:0]            opcode,
    input  wire                  acc_overflow,
    output reg  [DATA_WIDTH-1:0] data_out
);

`include "sap1_header.vh"

// declare register variables
reg [DATA_WIDTH-1:0] registerA;
reg [DATA_WIDTH-1:0] registerB;
reg [2*DATA_WIDTH-1:0] registerC; // store the result of the multiplication
reg [2*DATA_WIDTH:0] accumulator;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) begin // asynchronous reset
        registerA   <= {DATA_WIDTH{1'b0}};
        registerB   <= {DATA_WIDTH{1'b0}};
        registerC   <= {2*DATA_WIDTH{1'b0}};
        accumulator <= {2*DATA_WIDTH{1'b0}};
        data_out    <= {DATA_WIDTH{1'b0}};
    end else begin
        case (opcode)
            MAC_REGA: registerA <= data_in; // load register A
            MAC_REGB: registerB <= data_in; // load register B
            MAC_MULT: registerC <= registerA * registerB; // multiply
            MAC_ACC: accumulator <= accumulator + registerC; // accumulate
            MAC_MSW: data_out <= accumulator[2*DATA_WIDTH-1:1*DATA_WIDTH]; // output MSB
            MAC_LSW: data_out <= accumulator[1*DATA_WIDTH-1:0*DATA_WIDTH]; // output LSB
            MAC_RESET: accumulator <= {2*DATA_WIDTH{1'b0}}; // reset accumulator
            default: accumulator <= accumulator; // do nothing
        endcase
    end
end

// assert overflow flag when MSB is set
assign acc_overflow = accumulator[2*DATA_WIDTH];

endmodule
