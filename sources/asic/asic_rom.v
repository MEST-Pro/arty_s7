//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nick Stasi
// 
// Create Date: 12/23/2023 11:05:28 PM
// Design Name: 
// Module Name: asic_rom
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


module asic_rom #(
      parameter D_WIDTH    =  16,
      parameter ADDR_WIDTH =   8,
      parameter DEPTH      = 256
)(  
      input  wire clka,
      input  wire ena,
      input  wire addra,
      output  reg douta,
);
                                      

reg [DEPTH-1 : 0] ROM[D_WIDTH-1 : 0];

always@(*) begin
  ROM[0] = 16'h5000; ROM[1] = 16'h310F; ROM[2] = 16'h321A; ROM[3] = 16'h5100;
  ROM[4] = 16'h5200; ROM[5] = 16'h3126; ROM[6] = 16'h3205; ROM[7] = 16'h5100;
  ROM[8] = 16'h5200; ROM[9] = 16'h3103; ROM[10] = 16'h3211; ROM[11] = 16'h5100;
  ROM[12] = 16'h5200; ROM[13] = 16'h6100; ROM[14] = 16'h6200; ROM[15] = 16'hF000;
end

always@(posedge clka) begin
  if (ena == 1)
    douta = ROM[addra];
end


endmodule
