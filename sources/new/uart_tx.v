//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/27/2023 07:09:42 PM
// Design Name: 
// Module Name: uart_tx
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

module uart_tx #(
    parameter START_BIT     = 1,
    parameter DATA_BIT      = 8,
    parameter PARITY_BIT    = 1,
    parameter STOP_BIT      = 1,
    parameter CLOCK_PER_BIT = 1000 // baud rate bit per second = clock rate / clock per bit 
)(  
    input  wire                  clk,
    input  wire                  a_reset_n, // asynchronous reset
    // user interface
    output wire                  ready_out,
    input  wire                  valid_in,
    input  wire [DATA_BIT-1:0]   data_in,
    // uart interface
    output wire                  uart_out
);

//// State Machine ////

localparam [2:0] ST_IDLE      = 0;
localparam [2:0] ST_START_BIT = 1;
localparam [2:0] ST_DATA_BIT  = 2;
localparam [2:0] ST_PARITY    = 3;
localparam [2:0] ST_STOP      = 4;

reg [2:0] state_reg;
reg [2:0] state_next;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        state_reg <= ST_IDLE;
    else
        state_reg <= state_next;
end

//// Data FIFO ////

wire                data_fifo_srst;
wire [DATA_BIT-1:0] data_fifo_wdata;
wire                data_fifo_wen;
reg                 data_fifo_ren;
wire [DATA_BIT-1:0] data_fifo_rdata;
wire                data_fifo_full;
wire                data_fifo_wack;
wire                data_fifo_overflow;
wire                data_fifo_empty;
wire                data_fifo_valid;
wire                data_fifo_underflow;

assign data_fifo_wen = valid_in;
assign data_fifo_wdata = data_in;
assign data_fifo_srst = !a_reset_n; // active high reset

uart_data_fifo tx_uart_data_fifo (
  .clk          (clk),
  .srst         (data_fifo_srst),
  .din          (data_fifo_wdata),
  .wr_en        (data_fifo_wen),
  .rd_en        (data_fifo_ren),
  .dout         (data_fifo_rdata),
  .full         (data_fifo_full),
  .wr_ack       (data_fifo_wack),
  .overflow     (data_fifo_overflow),
  .empty        (data_fifo_empty),
  .valid        (data_fifo_valid),
  .underflow    (data_fifo_underflow)
);

assign ready_out = !data_fifo_full;

//// Clock Counter ////

localparam COUNT_WIDTH = 16;

wire                  clock_count_limit;
reg                   clock_count_rst;
reg [COUNT_WIDTH-1:0] clock_count;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        clock_count <= {COUNT_WIDTH{1'b0}};
    else if ((clock_count_rst == 1'b1) || (clock_count_limit == 1'b1)) 
        clock_count <= {COUNT_WIDTH{1'b0}};
    else
        clock_count <= clock_count + 1;
end

assign clock_count_limit = (clock_count == (CLOCK_PER_BIT-1));

//// Data Bit Shifter ////

reg                data_bit_shift_en;
reg [DATA_BIT-1:0] data_bit_shift_reg;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        data_bit_shift_reg <= {DATA_BIT{1'b0}};
    else if (data_fifo_valid == 1'b1) // load bit shift register
        data_bit_shift_reg <= data_fifo_rdata;
    else if (data_bit_shift_en == 1'b1)
        data_bit_shift_reg <= {1'b0,data_bit_shift_reg[DATA_BIT-1:1]};
end

//// Data Bit Counter ////

localparam DATA_BIT_WIDTH = 4;

reg                      data_bit_count_rst;
reg [DATA_BIT_WIDTH-1:0] data_bit_count;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        data_bit_count <= {DATA_BIT_WIDTH{1'b0}};
    else if (data_bit_count_rst == 1'b1)
        data_bit_count <= {DATA_BIT_WIDTH{1'b0}};
    else if (data_bit_shift_en == 1'b1)
        data_bit_count <= data_bit_count + 1;
end

//// Parity Check ////

wire parity_bit;
reg  parity_flag;
reg  parity_flag_reg;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        parity_flag_reg <= 1'b0;
    else if (parity_flag == 1'b1)
        parity_flag_reg <= parity_bit;
end

assign parity_bit = ^data_bit_shift_reg; // reduction XOR

//// Stop Bit Counter ////

reg       stop_bit_count_rst;
reg       stop_bit_count_inc;
reg [1:0] stop_bit_count;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        stop_bit_count <= 2'b00;
    else if (stop_bit_count_rst == 1'b1)
        stop_bit_count <= 2'b00;
    else if (stop_bit_count_inc == 1'b1)
        stop_bit_count <= stop_bit_count + 1;
end

//////// State Machine Logic ////////

reg data_bit_serial;

assign uart_out = data_bit_serial;

always@(*) begin
    
    // default condition
    state_next         = state_reg;
    clock_count_rst    = 1'b0;
    data_bit_shift_en  = 1'b0;
    data_bit_count_rst = 1'b0;
    parity_flag        = 1'b0;
    stop_bit_count_rst = 1'b0;
    stop_bit_count_inc = 1'b0;
    data_fifo_ren      = 1'b0;
    data_bit_serial    = 1'b1; // drive line high

    case (state_reg)
        
        //// Idle ////
        ST_IDLE: begin
            clock_count_rst = 1'b1;
            if (data_fifo_empty == 1'b0) begin
                data_fifo_ren = 1'b1;
                state_next = ST_START_BIT;
            end
        end
        
        //// Start Bit ////
        ST_START_BIT: begin
            data_bit_serial = 1'b0; // drive output low during start bit
            if (clock_count_limit == 1'b1) begin
                data_bit_count_rst = 1'b1;
                parity_flag = 1'b1; // latch the parity bit
                state_next = ST_DATA_BIT;
            end
        end
        
        //// Data Bit ////
        ST_DATA_BIT: begin
            data_bit_serial = data_bit_shift_reg[0]; // send data LSB to MSB
            if (clock_count_limit == 1'b1) begin
                data_bit_shift_en = 1'b1; // data bit shift
                if (data_bit_count == (DATA_BIT-1)) begin
                    if (PARITY_BIT > 0) begin
                        state_next = ST_PARITY;
                    end else begin
                        stop_bit_count_rst = 1'b1;
                        state_next = ST_STOP;
                    end
                end
            end
        end
        
        //// Parity Bit ////
        ST_PARITY: begin
            data_bit_serial = parity_flag_reg;
            if (clock_count_limit == 1'b1) begin
                stop_bit_count_rst = 1'b1;
                state_next = ST_STOP;
            end
        end
        
        //// Stop Bit ////
        ST_STOP: begin
            data_bit_serial = 1'b1; // send stop bits
            if (clock_count_limit == 1'b1) begin
                stop_bit_count_inc = 1'b1;
                if (stop_bit_count == (STOP_BIT-1)) begin // reached the end of the stop bits
                    clock_count_rst = 1'b1;
                    if (data_fifo_empty == 1'b0) begin // transmit fifo not empty
                        data_fifo_ren = 1'b1; // read next data word
                        state_next = ST_START_BIT;
                    end else begin
                        state_next = ST_IDLE; // end uart transmission
                    end
                end
            end
        end
        
        //// Default ////
        default: state_next = ST_IDLE;
    endcase
    
end

endmodule
