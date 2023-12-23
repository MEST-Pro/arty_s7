// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Tue Nov 28 19:05:38 2023
// Host        : DESKTOP-JJ88F0M running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/kirkg/project_arty_s7/project_arty_s7.gen/sources_1/ip/uart_data_fifo/uart_data_fifo_stub.v
// Design      : uart_data_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s25csga324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_7,Vivado 2022.2" *)
module uart_data_fifo(clk, srst, din, wr_en, rd_en, dout, full, wr_ack, 
  overflow, empty, valid, underflow)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[7:0],wr_en,rd_en,dout[7:0],full,wr_ack,overflow,empty,valid,underflow" */;
  input clk;
  input srst;
  input [7:0]din;
  input wr_en;
  input rd_en;
  output [7:0]dout;
  output full;
  output wr_ack;
  output overflow;
  output empty;
  output valid;
  output underflow;
endmodule
