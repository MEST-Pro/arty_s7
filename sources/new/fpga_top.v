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

module fpga_top(
    // Local Oscillator
    input OSC100MHZ,
    input OSC12MHZ,
    // UART
    output UART_TX,
    // Buttons
    input [3:0] BTN,
    // Slide Switches
    input [3:0] SW,
    // Tri-Color LED
    output [1:0] RLED,
    output [1:0] GLED,
    output [1:0] BLED,
    // User LED
    output [3:0] LED
);

// define processor parameter
localparam DATA_WIDTH = 16; // data bus width
localparam ADDR_WIDTH = 8; // program counter width
localparam RAM_DEPTH  = 2**ADDR_WIDTH; // instruction & data memory depth

//// Processor Phase Locked Loop ////

wire CLK115P2MHZ;
wire pll_lock;
wire pll_reset;

assign pll_reset = BTN[0];

fpga_pll fpga_pll_global (
    .clk_in     (OSC12MHZ),
    .reset      (pll_reset),
    .locked     (pll_lock),
    .clk_out    (CLK115P2MHZ)
);

assign LED[1] = pll_lock; // drive LED with pll lock status

//// Reset Synchronzier ////

wire a_reset;
wire s_reset;

// send reset pulse if pll unlocked or external reset asserted
assign a_reset = ~pll_lock || pll_reset;

rst_sync rst_sync_global (  
    .clk        (CLK115P2MHZ),
    .a_reset    (a_reset),
    .s_reset    (s_reset)
);

wire RST115P2MHZ; // active low reset

assign RST115P2MHZ = !s_reset;

//// Heartbeat Monitor ////

// drive LED0 with heartbeat
clk_led clk_led_heartbeat (  
    .clk        (CLK115P2MHZ),
    .a_reset_n  (RST115P2MHZ),
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
    .clk            (CLK115P2MHZ),
    .a_reset_n      (RST115P2MHZ),
    .reset          (pc_reset),
    .load           (pc_load), 
    .load_data      (pc_load_data),
    .increment      (pc_increment),
    .out_of_range   (pc_out_of_range),
    .counter        (pc_counter)
);

//// Memory Address Register ////

wire                  addr_reg_en;
wire                  addr_reg_valid;
wire [ADDR_WIDTH-1:0] addr_reg_data_in;
wire [ADDR_WIDTH-1:0] addr_reg_data_out;

generic_register #(.REG_WIDTH(ADDR_WIDTH)) addr_reg (  
    .clk        (CLK115P2MHZ),
    .a_reset_n  (RST115P2MHZ),
    .enable     (addr_reg_en),
    .data_in    (addr_reg_data_in),
    .valid      (addr_reg_valid),
    .data_out   (addr_reg_data_out)
);

//// Memory Write Data Register ////

wire                  data_reg_en;
wire                  data_reg_valid;
wire [DATA_WIDTH-1:0] data_reg_data_in;
wire [DATA_WIDTH-1:0] data_reg_data_out;

generic_register #(.REG_WIDTH(DATA_WIDTH)) data_reg (  
    .clk        (CLK115P2MHZ),
    .a_reset_n  (RST115P2MHZ),
    .enable     (data_reg_en),
    .data_in    (data_reg_data_in),
    .valid      (data_reg_valid),
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
    .clk    (CLK115P2MHZ),
    .wen    (mem_wen),
    .addr   (mem_addr),
    .wdata  (mem_wdata),
    .rdata  (mem_rdata)
);

//// Instruction Register ////

wire                  inst_reg_en;
wire                  inst_reg_valid;
wire [DATA_WIDTH-1:0] inst_reg_data_in;
wire [DATA_WIDTH-1:0] inst_reg_data_out;

generic_register #(.REG_WIDTH(DATA_WIDTH)) inst_reg (  
    .clk        (CLK115P2MHZ),
    .a_reset_n  (RST115P2MHZ),
    .enable     (inst_reg_en),
    .data_in    (inst_reg_data_in),
    .valid      (inst_reg_valid),
    .data_out   (inst_reg_data_out)
);

//// Arithmetic Logic Unit ////

wire                  alu_acc_zero;
wire                  alu_acc_overflow;
wire [3:0]            alu_opcode;
wire [DATA_WIDTH-1:0] alu_data_in;
wire [DATA_WIDTH-1:0] alu_data_out;

alu #(.DATA_WIDTH(DATA_WIDTH)) alu_unit (  
    .clk            (CLK115P2MHZ),
    .a_reset_n      (RST115P2MHZ),
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
    .clk        (CLK115P2MHZ),
    .a_reset_n  (RST115P2MHZ),
    .data_in    (mac_data_in),
    .opcode     (mac_opcode),
    .data_out   (mac_data_out)
);

//// Output Register ////

wire                  out_reg_en;
wire                  out_reg_valid;
wire [DATA_WIDTH-1:0] out_reg_data_in;
wire [DATA_WIDTH-1:0] out_reg_data_out;

generic_register #(.REG_WIDTH(DATA_WIDTH)) out_reg (  
    .clk        (CLK115P2MHZ),
    .a_reset_n  (RST115P2MHZ),
    .enable     (out_reg_en),
    .data_in    (out_reg_data_in),
    .valid      (out_reg_valid),
    .data_out   (out_reg_data_out)
);

//// UART Transmitter ////

uart_top #(.DATA_WIDTH(DATA_WIDTH),.CLOCK_PER_BIT(1000)) uart_top_inst (  
    .clk            (CLK115P2MHZ),
    .a_reset_n      (RST115P2MHZ),
    .data_en        (out_reg_valid),
    .data_in        (out_reg_data_in),
    .uart_out       (UART_TX)
);

//// Processor Bus ////

localparam NUM_BUS_INPUT = 6;
localparam NUM_BUS_OUTPUT = 7;

wire [NUM_BUS_INPUT*DATA_WIDTH-1:0]  bus_data_in;
wire [2:0]                           bus_sel_in;
wire [NUM_BUS_OUTPUT*DATA_WIDTH-1:0] bus_data_out;

bus_mux #(.NUM_INPUT(NUM_BUS_INPUT),.NUM_OUTPUT(NUM_BUS_OUTPUT),.SEL_BIT(3),.DATA_WIDTH(DATA_WIDTH)) cpu_bus (
    .clk        (CLK115P2MHZ),
    .data_in    (bus_data_in),
    .sel_in     (bus_sel_in),
    .data_out   (bus_data_out)
);

//// Processor Controller ////

wire                  error_state;
wire [DATA_WIDTH-1:0] ctrl_data_out;

sap1_controller #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) cpu_controller (
    .clk                (CLK115P2MHZ),
    .a_reset_n          (RST115P2MHZ),
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