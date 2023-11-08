`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 07:28:08 PM
// Design Name: 
// Module Name: mestpro_pkg
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

package mestpro_pkg;

//////////////////////////////////////////////////////////////////////////////////
// Array Block
//////////////////////////////////////////////////////////////////////////////////

// Opcode

localparam OPCODE_BIT = 3;

localparam [OPCODE_BIT-1:0] OP_RESET = 3'b000;
localparam [OPCODE_BIT-1:0] OP_WRITE = 3'b001;
localparam [OPCODE_BIT-1:0] OP_READ  = 3'b010;
localparam [OPCODE_BIT-1:0] OP_PUSH  = 3'b011;
localparam [OPCODE_BIT-1:0] OP_POP   = 3'b100;
localparam [OPCODE_BIT-1:0] OP_NEXT  = 3'b101;

// Error

localparam ERROR_BIT = 2;

localparam [ERROR_BIT-1:0] ERROR_NONE    = 2'b00; // no error 
localparam [ERROR_BIT-1:0] ERROR_EMPTY   = 2'b01; // read when queue/stack is empty
localparam [ERROR_BIT-1:0] ERROR_FULL    = 2'b10; // write when queue/stack is full
localparam [ERROR_BIT-1:0] ERROR_INVALID = 2'b11; // invalid opcode

endpackage
