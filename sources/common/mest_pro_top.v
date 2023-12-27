//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 10/25/2023 07:23:05 PM
// Design Name:
// Module Name: fpga_top
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

module mest_pro_top #(
    parameter ASIC = 0
)(
    // Local Oscillator
    input i_CLK100MHZ,
    // Buttons
    input [3:0] BTN,
    // Slide Switches
    input [3:0] SW,
    // Tri-Color LED
    output [1:0] RLED,
    output [1:0] GLED,
    output [1:0] BLED,
    // User LED
    output [3:0] LED,
    //output reg
    output [15:0] out_reg_data_out
);

// define processor parameter
localparam DATA_WIDTH = 16; // data bus width
localparam ADDR_WIDTH = 8; // program counter width
localparam RAM_DEPTH  = 2**ADDR_WIDTH; // instruction & data memory depth

//// Phase Locked Loop ////

wire clk100MHz;
wire pll_lock;
reg  pll_lock_reg;
wire pll_reset;
reg [15:0] asic_pll_ctr;
localparam ASIC_PLL_CTR_MAX = 512;

assign pll_reset = BTN[0];

generate
  if( ASIC == 0) begin
    fpga_pll fpga_pll_100MHz (
        .clk_in     (i_CLK100MHZ), // input clock
        .reset      (pll_reset), // input reset
        .locked     (pll_lock),  // output locked
        .clk100MHz  (clk100MHz)  // output clk100MHz
    );
  end else begin
    assign clk100MHz = i_CLK100MHZ;
    assign pll_lock  = pll_lock_reg;
    always@(posedge clk100MHz) begin
      if((asic_pll_ctr > ASIC_PLL_CTR_MAX) && (pll_lock_reg == 0))
        pll_lock_reg <= 1;
      else if(pll_lock_reg == 0)
        asic_pll_ctr <= asic_pll_ctr + 1;
    end
  end
endgenerate

//// Reset Synchronzier ////

wire a_reset;
wire s_reset;

// send reset pulse if pll unlocked or external reset asserted
assign a_reset = ~pll_lock || pll_reset;

rst_sync rst_sync_100MHz (  
    .clk        (clk100MHz),
    .a_reset    (a_reset),
    .s_reset    (s_reset)
);

wire rst100MHz; // active low reset

assign rst100MHz = !s_reset;

//// Heartbeat Monitor ////

// drive LED0 with 100MHZ heartbeat
clk_led clk_led_100MHz (  
    .clk        (clk100MHz),
    .a_reset_n  (rst100MHz),
    .led_out    (LED[0])
);

//// Program Counter ////

wire                  pc_reset;
wire                  pc_load;
wire                  pc_increment;
wire                  pc_out_of_range;
wire [ADDR_WIDTH-1:0] pc_load_data;
wire [ADDR_WIDTH-1:0] pc_counter;

counter #(.COUNT_WIDTH(ADDR_WIDTH)) program_counter (  
    .clk            (clk100MHz),
    .a_reset_n      (rst100MHz),
    .reset          (pc_reset),
    .load           (pc_load), 
    .load_data      (pc_load_data),
    .increment      (pc_increment),
    .out_of_range   (pc_out_of_range),
    .counter        (pc_counter)
);

//// Memory Address Register ////

wire                  addr_reg_en;
wire [ADDR_WIDTH-1:0] addr_reg_data_in;
wire [ADDR_WIDTH-1:0] addr_reg_data_out;

generic_register #(.REG_WIDTH(ADDR_WIDTH)) addr_reg (  
    .clk        (clk100MHz),
    .a_reset_n  (rst100MHz),
    .enable     (addr_reg_en),
    .data_in    (addr_reg_data_in),
    .data_out   (addr_reg_data_out)
);

//// Memory Write Data Register ////

wire                  data_reg_en;
wire [DATA_WIDTH-1:0] data_reg_data_in;
wire [DATA_WIDTH-1:0] data_reg_data_out;

generic_register #(.REG_WIDTH(DATA_WIDTH)) data_reg (  
    .clk        (clk100MHz),
    .a_reset_n  (rst100MHz),
    .enable     (data_reg_en),
    .data_in    (data_reg_data_in),
    .data_out   (data_reg_data_out)
);

//// Instruction & Data Memory ////

wire                  mem_wen;
wire [ADDR_WIDTH-1:0] mem_addr;
wire [DATA_WIDTH-1:0] mem_wdata;
wire [DATA_WIDTH-1:0] mem_rdata;

assign mem_addr = addr_reg_data_out;
assign mem_wdata = data_reg_data_out;

block_ram #(.ADDR_WIDTH(ADDR_WIDTH),.RAM_WIDTH(DATA_WIDTH),.RAM_DEPTH(RAM_DEPTH)) cpu_mem (  
    .clk    (clk100MHz),
    .wen    (mem_wen),
    .addr   (mem_addr),
    .wdata  (mem_wdata),
    .rdata  (mem_rdata)
);

//// Instruction Register ////

wire                  inst_reg_en;
wire [DATA_WIDTH-1:0] inst_reg_data_in;
wire [DATA_WIDTH-1:0] inst_reg_data_out;

generic_register #(.REG_WIDTH(DATA_WIDTH)) inst_reg (  
    .clk        (clk100MHz),
    .a_reset_n  (rst100MHz),
    .enable     (inst_reg_en),
    .data_in    (inst_reg_data_in),
    .data_out   (inst_reg_data_out)
);

//// Arithmetic Logic Unit ////

wire                  alu_acc_zero;
wire                  alu_acc_overflow;
wire [3:0]            alu_opcode;
wire [DATA_WIDTH-1:0] alu_data_in;
wire [DATA_WIDTH-1:0] alu_data_out;

alu #(.DATA_WIDTH(DATA_WIDTH)) alu_unit (  
    .clk            (clk100MHz),
    .a_reset_n      (rst100MHz),
    .acc_overflow   (alu_acc_overflow),
    .acc_zero       (alu_acc_zero),
    .data_in        (alu_data_in),
    .opcode         (alu_opcode),
    .data_out       (alu_data_out)
);

//// Multiply Accumulate Unit ////

wire [3:0]            mac_opcode;
wire [DATA_WIDTH-1:0] mac_data_in;
wire [DATA_WIDTH-1:0] mac_data_out;

mac #(.DATA_WIDTH(DATA_WIDTH)) mac_unit ( 
    .clk        (clk100MHz),
    .a_reset_n  (rst100MHz),
    .data_in    (mac_data_in),
    .opcode     (mac_opcode),
    .data_out   (mac_data_out)
);

//// Output Register ////

wire                  out_reg_en;
wire [DATA_WIDTH-1:0] out_reg_data_in;
wire [DATA_WIDTH-1:0] out_reg_data_out;

generic_register #(.REG_WIDTH(DATA_WIDTH)) output_register (  
    .clk        (clk100MHz),
    .a_reset_n  (rst100MHz),
    .enable     (out_reg_en),
    .data_in    (out_reg_data_in),
    .data_out   (out_reg_data_out)
);

//// Processor Bus ////

localparam NUM_BUS_INPUT = 6;
localparam NUM_BUS_OUTPUT = 7;

wire [NUM_BUS_INPUT*DATA_WIDTH-1:0]  bus_data_in;
wire [2:0]                           bus_sel_in;
wire [NUM_BUS_OUTPUT*DATA_WIDTH-1:0] bus_data_out;

bus_mux #(.NUM_INPUT(NUM_BUS_INPUT),.NUM_OUTPUT(NUM_BUS_OUTPUT),.SEL_BIT(3),.DATA_WIDTH(DATA_WIDTH)) cpu_bus (
    .clk        (clk100MHz),
    .data_in    (bus_data_in),
    .sel_in     (bus_sel_in),
    .data_out   (bus_data_out)
);

//// Processor Controller ////

wire                  error_state;
wire [DATA_WIDTH-1:0] ctrl_data_out;

sap1_controller #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH),.ASIC(ASIC)) cpu_controller (
    .clk                (clk100MHz),
    .a_reset_n          (rst100MHz),
    .start              (BTN[1]),
    .inst_reg           (inst_reg_data_out),
    .pc_out_of_range    (pc_out_of_range),
    .pc_reset           (pc_reset),
    .pc_load            (pc_load),
    .pc_increment       (pc_increment),
    .error_state        (error_state),
    .addr_reg_en        (addr_reg_en),
    .data_reg_en        (data_reg_en),
    .mem_wen            (mem_wen),
    .inst_reg_en        (inst_reg_en),
    .alu_acc_overflow   (alu_acc_overflow),
    .alu_acc_zero       (alu_acc_zero),
    .alu_opcode         (alu_opcode),
    .mac_opcode         (mac_opcode),
    .out_reg_en         (out_reg_en),
    .bus_sel_in         (bus_sel_in),
    .data_out           (ctrl_data_out)
);

assign LED[2] = error_state; // light LED if error occurred

//// Processor Bus Interface ////

// bus input logic
assign bus_data_in[0*DATA_WIDTH+:DATA_WIDTH] = {{(DATA_WIDTH-ADDR_WIDTH){1'b0}},pc_counter};
assign bus_data_in[1*DATA_WIDTH+:DATA_WIDTH] = mem_rdata;
assign bus_data_in[2*DATA_WIDTH+:DATA_WIDTH] = alu_data_out;
assign bus_data_in[3*DATA_WIDTH+:DATA_WIDTH] = mac_data_out;
assign bus_data_in[4*DATA_WIDTH+:DATA_WIDTH] = inst_reg_data_out;
assign bus_data_in[5*DATA_WIDTH+:DATA_WIDTH] = ctrl_data_out;

// bus output logic
assign pc_load_data     = bus_data_out[0*DATA_WIDTH+:ADDR_WIDTH];
assign addr_reg_data_in = bus_data_out[1*DATA_WIDTH+:ADDR_WIDTH];
assign data_reg_data_in = bus_data_out[2*DATA_WIDTH+:DATA_WIDTH];
assign alu_data_in      = bus_data_out[3*DATA_WIDTH+:DATA_WIDTH];
assign mac_data_in      = bus_data_out[4*DATA_WIDTH+:DATA_WIDTH];
assign inst_reg_data_in = bus_data_out[5*DATA_WIDTH+:DATA_WIDTH];
assign out_reg_data_in  = bus_data_out[6*DATA_WIDTH+:DATA_WIDTH];

endmodule
