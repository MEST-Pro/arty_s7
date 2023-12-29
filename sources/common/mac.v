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

// define alu instructions
localparam [3:0] ALU_RESET  = 4'h0;
localparam [3:0] ALU_ADD    = 4'h1;
localparam [3:0] ALU_SUB    = 4'h2;
localparam [3:0] ALU_AND    = 4'h3;
localparam [3:0] ALU_OR     = 4'h4;
localparam [3:0] ALU_XOR    = 4'h5;
localparam [3:0] ALU_LSHIFT = 4'h6;
localparam [3:0] ALU_RSHIFT = 4'h7;
// processor reserved
localparam [3:0] ALU_REGA   = 4'h8;
localparam [3:0] ALU_OUT    = 4'h9;
localparam [3:0] ALU_NOOP   = 4'hF;

// define mac instructions
localparam [3:0] MAC_RESET = 4'h0;
localparam [3:0] MAC_MULT  = 4'h1;
localparam [3:0] MAC_ACC   = 4'h2;
// processor reserved
localparam [3:0] MAC_REGA  = 4'h4;
localparam [3:0] MAC_REGB  = 4'h5;
localparam [3:0] MAC_MSW   = 4'h6;
localparam [3:0] MAC_LSW   = 4'h7;
localparam [3:0] MAC_NOOP  = 4'hF;

// bus select logic
localparam [2:0] BUS_SEL_PC   = 0;
localparam [2:0] BUS_SEL_MEM  = 1;
localparam [2:0] BUS_SEL_ALU  = 2;
localparam [2:0] BUS_SEL_MAC  = 3;
localparam [2:0] BUS_SEL_INST = 4;
localparam [2:0] BUS_SEL_CTRL = 5;

// instruction opcode
localparam [3:0] OP_NOOP = 0; // no operation
localparam [3:0] OP_LOAD = 1; // load memory data into register
localparam [3:0] OP_STORE = 2; // load register data into memory
localparam [3:0] OP_MOV = 3; // load constant data into register
localparam [3:0] OP_ALU = 4; // execute ALU operation
localparam [3:0] OP_MAC = 5; // execute MAC operation
localparam [3:0] OP_OUT = 6; // load result to output register
localparam [3:0] OP_BRANCH = 7; // branch to address
localparam [3:0] OP_HLT = 15; // stop processing

// destination register
localparam [3:0] REG_ALUA = 0; // ALU register A
localparam [3:0] REG_MACA = 1; // MAC register A
localparam [3:0] REG_MACB = 2; // MAC register B

// result register
localparam [3:0] REG_ALU     = 0; // ALU accumulator
localparam [3:0] REG_MAC_MSW = 1; // MAC accumulator upper word
localparam [3:0] REG_MAC_LSW = 2; // MAC accumulator lower word

// branch condition
localparam [3:0] BRANCH_EQ   = 0;
localparam [3:0] BRANCH_NEQ  = 1;
localparam [3:0] BRANCH_GT   = 2;
localparam [3:0] BRANCH_GTEQ = 3;
localparam [3:0] BRANCH_LT   = 4;
localparam [3:0] BRANCH_LTEQ = 5;

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
