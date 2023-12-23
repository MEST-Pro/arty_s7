//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/28/2023 07:25:08 PM
// Design Name: 
// Module Name: uart_top
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

module uart_top #(
    parameter DATA_WIDTH = 16,
    parameter CLOCK_PER_BIT = 1000 // baud rate bit per second = clock rate / clock per bit 
)(  
    input  wire                  clk,
    input  wire                  a_reset_n, // asynchronous reset
    // user interface
    input  wire                  data_en,
    input  wire [DATA_WIDTH-1:0] data_in,
    // uart interface
    output wire                  uart_out
);

//// Data Byte Shifter ////

localparam UART_DATA_BIT = 8;
localparam UART_DATA_BYTE = DATA_WIDTH/UART_DATA_BIT;

reg [UART_DATA_BYTE-1:0] data_reg_en;
reg [DATA_WIDTH-1:0]     data_reg;
wire                     uart_ready;
wire                     uart_valid;
wire [UART_DATA_BIT-1:0] uart_data;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) begin
        data_reg <= {DATA_WIDTH{1'b0}};
        data_reg_en <= {UART_DATA_BYTE{1'b0}};
    end else if (data_en == 1'b1) begin
        data_reg <= data_in;
        data_reg_en <= {UART_DATA_BYTE{1'b1}};
    end else if (uart_valid == 1'b1) begin
        data_reg <= {data_reg[DATA_WIDTH-UART_DATA_BIT-1:0],{UART_DATA_BIT{1'b0}}};
        data_reg_en <= {data_reg_en[UART_DATA_BYTE-2:0],1'b0};
    end
end

assign uart_valid = |data_reg_en && (uart_ready == 1'b1);
assign uart_data = data_reg[DATA_WIDTH-1:DATA_WIDTH-UART_DATA_BIT];

//// UART Transmitter ////

uart_tx #(.CLOCK_PER_BIT(CLOCK_PER_BIT)) uart_tx (  
    .clk        (clk),
    .a_reset_n  (a_reset_n),
    .ready_out  (uart_ready),
    .valid_in   (uart_valid),
    .data_in    (uart_data),
    .uart_out   (uart_out)
);

endmodule
