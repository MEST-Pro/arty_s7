//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/08/2023 05:43:26 PM
// Design Name: 
// Module Name: block_ram
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

// Simple Dual-Port Block RAM
module block_ram #(
    parameter ADDR_WIDTH = 4,
    parameter RAM_WIDTH = 8,
    parameter RAM_DEPTH = 16
)(  
    input  wire                  clk,
    input  wire                  wen,
    input  wire [ADDR_WIDTH-1:0] addr,
    input  wire [RAM_WIDTH-1:0]  wdata,
    output reg  [RAM_WIDTH-1:0]  rdata
);

// define memory variable to infer BRAM
reg [RAM_WIDTH-1:0] mem[0:RAM_DEPTH-1];

always@(posedge clk) begin

    if (wen)
        mem[addr] <= wdata; // write data
   
    rdata <= mem[addr]; // read data
    
end

endmodule
