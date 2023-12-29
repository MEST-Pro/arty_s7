//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kirk Goleniak
// 
// Create Date: 11/11/2023 02:59:41 PM
// Design Name: 
// Module Name: sap1_controller
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

module sap1_controller #(
    parameter BUS_LATENCY = 3,
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 8,
    parameter ASIC       = 0
)(  
    input  wire                  clk,
    input  wire                  a_reset_n, // asynchronous reset
    input  wire                  start,
    input  wire                  alu_acc_overflow,
    input  wire                  alu_acc_zero,
    input  wire [DATA_WIDTH-1:0] inst_reg,
    input  wire                  pc_out_of_range,
    output reg                   pc_reset,
    output reg                   pc_load,
    output reg                   pc_increment,
    output wire                  error_state,
    output reg                   addr_reg_en,
    output reg                   data_reg_en,
    output reg                   mem_wen,
    output reg                   inst_reg_en,
    output reg  [3:0]            alu_opcode,
    output reg  [3:0]            mac_opcode,
    output reg                   out_reg_en,
    output reg  [2:0]            bus_sel_in,
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

// define state machine states
localparam [4:0] ST_IDLE            = 0;
localparam [4:0] ST_LOAD_INST_ADDR  = 1;
localparam [4:0] ST_READ_INST_MEM   = 2;
localparam [4:0] ST_LOAD_INST_REG   = 3;
localparam [4:0] ST_DECODE_INST     = 4;
localparam [4:0] ST_LOAD_READ_ADDR  = 5;
localparam [4:0] ST_READ_DATA_MEM   = 6;
localparam [4:0] ST_LOAD_OP_REG     = 7;
localparam [4:0] ST_RUN_OPCODE      = 8;
localparam [4:0] ST_LOAD_WRITE_ADDR = 9;
localparam [4:0] ST_LOAD_WRITE_DATA = 10;
localparam [4:0] ST_WRITE_DATA_MEM  = 11;
localparam [4:0] ST_LOAD_PC         = 12;
localparam [4:0] ST_UPDATE_OUTPUT   = 13;
localparam [4:0] ST_LOAD_OUT_REG    = 14;
localparam [4:0] ST_ERROR           = 15;
localparam [4:0] ST_LOAD_ROM_ADDR   = 16;
localparam [4:0] ST_READ_ROM_DATA   = 17;
localparam [4:0] ST_LOAD_ROM_DATA   = 18;
localparam [4:0] ST_WRITE_ROM_DATA  = 19;

//// State Register ////

reg [4:0] stateReg;
reg [4:0] stateNext;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        stateReg <= ST_IDLE;
    else
        stateReg <= stateNext;
end

//// Bus Latency ////

wire                  bus_delay;
reg                   bus_active;
reg [BUS_LATENCY-1:0] bus_shift_reg;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        bus_shift_reg <= {BUS_LATENCY{1'b0}};
    else if (bus_delay == 1'b1)
        bus_shift_reg <= {BUS_LATENCY{1'b0}};
    else
        bus_shift_reg <= {bus_shift_reg[BUS_LATENCY-2:0],bus_active};
end

assign bus_delay = (bus_shift_reg == {BUS_LATENCY{1'b1}});

//// Read Only Memory (ROM) ////

localparam ROM_ADDR = 8;
localparam ROM_WIDTH = 16;
localparam ROM_DEPTH = 256;

reg                  rom_reset;
reg                  rom_enable;
reg  [ROM_ADDR-1:0]  rom_addr;
wire [ROM_WIDTH-1:0] rom_rdata;

generate
  if(ASIC == 0)
    fpga_rom sap1_program_rom (
      .clka     (clk),
      .ena      (rom_enable),
      .addra    (rom_addr),
      .douta    (rom_rdata)
    );
  else
    asic_rom sap1_program_rom (
      .clka     (clk),
      .ena      (rom_enable),
      .addra    (rom_addr),
      .douta    (rom_rdata)
    );
endgenerate

//// Read ROM Data ////

localparam ROM_READ_DELAY = 2;

localparam [ROM_READ_DELAY-1:0] ROM_DELAY = {ROM_READ_DELAY{1'b1}};

wire                     rom_delay;
reg [ROM_READ_DELAY-1:0] rom_shift_reg;

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        rom_shift_reg <= {ROM_READ_DELAY{1'b0}};
    else if (rom_delay == 1'b1)
        rom_shift_reg <= {ROM_READ_DELAY{1'b0}};
    else
        rom_shift_reg <= {rom_shift_reg[ROM_READ_DELAY-2:0],rom_enable};
end

assign rom_delay = (rom_shift_reg == ROM_DELAY);

//// ROM Read Address ////

always@(posedge clk or negedge a_reset_n) begin
    if (a_reset_n == 1'b0) // asynchronous reset
        rom_addr <= {ROM_ADDR{1'b0}};
    else if (rom_reset == 1'b1)
        rom_addr <= {ROM_ADDR{1'b0}};
    else if (mem_wen == 1'b1) // increment address
        rom_addr <= rom_addr + 1;
end

//// Pipeline Register ////

reg startReg;

always@(posedge clk) begin
    startReg <= start;
end

//////// Instruction Register ////////

reg [4:0] decode_state;

always@(*) begin
    case (inst_reg[15:12]) // decode opcode field
        OP_NOOP: decode_state = ST_LOAD_INST_ADDR;
        OP_LOAD: decode_state = ST_LOAD_READ_ADDR;
        OP_STORE: decode_state = ST_LOAD_WRITE_ADDR;
        OP_MOV: decode_state = ST_LOAD_OP_REG;
        OP_ALU: decode_state = ST_RUN_OPCODE;
        OP_MAC: decode_state = ST_RUN_OPCODE;
        OP_BRANCH: decode_state = ST_LOAD_PC; 
        OP_OUT: decode_state = ST_UPDATE_OUTPUT;
        OP_HLT: decode_state = ST_IDLE;
        default: decode_state = ST_ERROR;
    endcase
end

//// Decode Opcode ////

reg [3:0] decode_alu_opcode;
reg [3:0] decode_mac_opcode;

always@(*) begin
    case (inst_reg[15:12]) // decode opcode field
        OP_ALU: begin // ALU operation
            decode_alu_opcode = {1'b0,inst_reg[10:8]};
            decode_mac_opcode = MAC_NOOP;
        end
        OP_MAC: begin // MAC operation
            decode_alu_opcode = ALU_NOOP;
            decode_mac_opcode = {2'b00,inst_reg[9:8]};
        end
        default: begin
            decode_alu_opcode = ALU_NOOP;
            decode_mac_opcode = MAC_NOOP;
        end
    endcase
end

//// Load Output Register ////

reg [3:0] load_alu_output;
reg [3:0] load_mac_output;

always@(*) begin
    case (inst_reg[11:8]) // decode result field
        REG_ALU: begin // ALU accumulator
            load_alu_output = ALU_OUT;
            load_mac_output = MAC_NOOP;
        end
        REG_MAC_MSW: begin // MAC accumulator MSW
            load_alu_output = ALU_NOOP;
            load_mac_output = MAC_MSW;
        end
        REG_MAC_LSW: begin // MAC accumulator LSW
            load_alu_output = ALU_NOOP;
            load_mac_output = MAC_LSW;
        end
        default: begin
            load_alu_output = ALU_NOOP;
            load_mac_output = MAC_NOOP;
        end
    endcase
end

//// Load Input Register ////

reg [3:0] load_alu_input;
reg [3:0] load_mac_input;

always@(*) begin
    case (inst_reg[11:8]) // decode register field
        REG_ALUA: begin // ALU register A
            load_alu_input = ALU_REGA;
            load_mac_input = MAC_NOOP;
        end
        REG_MACA: begin // MAC register A
            load_alu_input = ALU_NOOP;
            load_mac_input = MAC_REGA;
        end
        REG_MACB: begin // MAC register B
            load_alu_input = ALU_NOOP;
            load_mac_input = MAC_REGB;
        end
        default: begin
            load_alu_input = ALU_NOOP;
            load_mac_input = MAC_NOOP;
        end
    endcase
end

//// Result Bus Select ////

reg [2:0] decode_bus_sel;

always@(*) begin
    case (inst_reg[11:8]) // decode result field
        REG_ALU: decode_bus_sel = BUS_SEL_ALU;
        REG_MAC_MSW: decode_bus_sel = BUS_SEL_MAC;
        REG_MAC_LSW: decode_bus_sel = BUS_SEL_MAC;
        default: decode_bus_sel = 3'b000;
    endcase
end

//// Branch Condition ////

reg decode_branch;

always@(*) begin
    case (inst_reg[11:8]) // decode condition field
        BRANCH_EQ: decode_branch = alu_acc_zero;
        BRANCH_NEQ: decode_branch = !alu_acc_zero;
        BRANCH_GT: decode_branch = !alu_acc_zero && !alu_acc_overflow;
        BRANCH_GTEQ: decode_branch = !alu_acc_overflow;
        BRANCH_LT: decode_branch = !alu_acc_zero && alu_acc_overflow;
        BRANCH_LTEQ: decode_branch = alu_acc_overflow;
        default: decode_branch = 1'b0; // do not take branch
    endcase
end

//////// State Machine Logic ////////

assign error_state = (stateReg == ST_ERROR);

always@(*) begin
    
    // default logic state
    pc_reset     = 1'b0;
    pc_load      = 1'b0;
    pc_increment = 1'b0;
    addr_reg_en  = 1'b0;
    data_reg_en  = 1'b0;
    mem_wen      = 1'b0;
    inst_reg_en  = 1'b0;
    alu_opcode   = ALU_NOOP;
    mac_opcode   = MAC_NOOP;
    out_reg_en   = 1'b0;
    bus_active   = 1'b0;
    bus_sel_in   = 3'b000;
    data_out     = {DATA_WIDTH{1'b0}};
    rom_reset    = 1'b0;
    rom_enable   = 1'b0;
    stateNext    = stateReg;
    
    //// State Decode Logic ////
    
    case (stateReg)
        
        //////// Idle ////////
        ST_IDLE: begin
            if ((start == 1'b1) && (startReg == 1'b0)) begin // positive edge of start signal
                pc_reset = 1'b1; // restart the program counter
                alu_opcode = ALU_RESET;
                mac_opcode = MAC_RESET;
                rom_reset = 1'b1; // restart the ROM address
                stateNext = ST_LOAD_ROM_ADDR; // fetch the initial program instruction
            end 
        end
        
        //////// Load ROM Address ////////
        ST_LOAD_ROM_ADDR: begin
            bus_active = 1'b1;
            bus_sel_in = BUS_SEL_CTRL;
            data_out[ADDR_WIDTH-1:0] = rom_addr; // send ROM address onto bus
            if (bus_delay == 1'b1) begin
                addr_reg_en = 1'b1; // load ROM address into memory address register
                stateNext = ST_READ_ROM_DATA;
            end
        end
        
        //////// Read ROM Data ////////
        ST_READ_ROM_DATA: begin
            rom_enable = 1'b1;
            if (rom_delay == 1'b1) begin
                stateNext = ST_LOAD_ROM_DATA;
            end
        end
        
        //////// Load ROM Data ////////
        ST_LOAD_ROM_DATA: begin
            rom_enable = 1'b1;
            bus_active = 1'b1;
            bus_sel_in = BUS_SEL_CTRL;
            data_out[DATA_WIDTH-1:0] = rom_rdata; // send ROM data onto bus
            if (bus_delay == 1'b1) begin
                data_reg_en = 1'b1; // load rom data to memory write data register
                stateNext = ST_WRITE_ROM_DATA;
            end
        end
        
        //////// Write ROM Data ////////
        ST_WRITE_ROM_DATA: begin
            mem_wen = 1'b1; // write operation
            if (rom_addr < (ROM_DEPTH-1))
                stateNext = ST_LOAD_ROM_ADDR; // fetch next rom data
            else
                stateNext = ST_LOAD_INST_ADDR; // fetch initial program instruction
        end
        
        //////// Load Instruction Address ////////
        ST_LOAD_INST_ADDR: begin
            if (pc_out_of_range == 1'b1) begin // program counter out of range
                stateNext = ST_ERROR;
            end else begin         
                bus_active = 1'b1;
                bus_sel_in = BUS_SEL_PC; // drive PC onto the bus
                if (bus_delay == 1'b1) begin
                    pc_increment = 1'b1; // increment PC for next instruction cycle
                    addr_reg_en = 1'b1; // load PC into memory address register
                    stateNext = ST_READ_INST_MEM;
                end  
            end
        end
        
        //////// Read Instruction Memory ////////
        ST_READ_INST_MEM: begin
            mem_wen = 1'b0; // read operation
            stateNext = ST_LOAD_INST_REG; // wait for memory read to complete
        end
        
        //////// Load Instruction Register ///////
        ST_LOAD_INST_REG: begin
            bus_active = 1'b1;
            bus_sel_in = BUS_SEL_MEM; // drive instruction onto the bus
            if (bus_delay == 1'b1) begin
                inst_reg_en = 1'b1; // load instruction into instruction register
                stateNext = ST_DECODE_INST;
            end
        end
        
        //////// Decode Instruction ////////
        ST_DECODE_INST: begin
            stateNext = decode_state;
        end
        
        //////// Load Read Data Address ////////
        ST_LOAD_READ_ADDR: begin
            bus_active = 1'b1;
            bus_sel_in = BUS_SEL_CTRL; // drive read address onto the bus
            data_out[ADDR_WIDTH-1:0] = inst_reg[ADDR_WIDTH-1:0];
            if (bus_delay == 1'b1) begin
                addr_reg_en = 1'b1; // load read address to memory address register
                stateNext = ST_READ_DATA_MEM;
            end
        end
        
        //////// Read Data Memory ////////
        ST_READ_DATA_MEM: begin
            mem_wen = 1'b0; // read operation
            stateNext = ST_LOAD_OP_REG;
        end
        
        //////// Load ALU/MAC Operand Regsiter ////////
        ST_LOAD_OP_REG: begin
            bus_active = 1'b1;
            if (inst_reg[15:12] == OP_MOV)
                bus_sel_in = BUS_SEL_CTRL; // drive value onto the bus
            else
                bus_sel_in = BUS_SEL_MEM; // drive the read data onto the bus
            data_out[DATA_WIDTH-1:0] = {{(DATA_WIDTH/2){1'b0}},inst_reg[DATA_WIDTH/2-1:0]};
            if (bus_delay == 1'b1) begin
                alu_opcode = load_alu_input;
                mac_opcode = load_mac_input;
                stateNext = ST_LOAD_INST_ADDR; // fetch next instruction
            end
        end

        //////// Execute ALU/MAC Opcode ////////
        ST_RUN_OPCODE: begin
            alu_opcode = decode_alu_opcode;
            mac_opcode = decode_mac_opcode;
            stateNext = ST_LOAD_INST_ADDR; // fetch next instruction
        end

        //////// Load Write Data Address ////////
        ST_LOAD_WRITE_ADDR: begin
            bus_active = 1'b1;
            bus_sel_in = BUS_SEL_CTRL; // drive read address onto the bus
            data_out[ADDR_WIDTH-1:0] = inst_reg[ADDR_WIDTH-1:0];
            if (bus_delay == 1'b1) begin
                addr_reg_en = 1'b1; // load read address to memory address register
                stateNext = ST_UPDATE_OUTPUT;
            end
        end
        
        //////// Load Write Data ////////
        ST_LOAD_WRITE_DATA: begin
            bus_active = 1'b1;
            bus_sel_in = decode_bus_sel; // drive write data onto the bus
            if (bus_delay == 1'b1) begin
                data_reg_en = 1'b1; // load write data to memory write data register
                stateNext = ST_WRITE_DATA_MEM;
            end
        end
        
        //////// Write Data Memory ////////
        ST_WRITE_DATA_MEM: begin
            mem_wen = 1'b1; // write operation
            stateNext = ST_LOAD_INST_ADDR; // fetch next instruction
        end
        
        //////// Load Program Counter ////////
        ST_LOAD_PC: begin
            if (decode_branch == 1'b1) begin // branch taken
                bus_active = 1'b1;
                bus_sel_in = BUS_SEL_CTRL; // drive branch address onto the bus
                data_out[ADDR_WIDTH-1:0] = inst_reg[ADDR_WIDTH-1:0];
                if (bus_delay == 1'b1) begin
                    pc_load = 1'b1; // load branch address to program counter
                    stateNext = ST_LOAD_INST_ADDR; // fetch next instruction
                end
             end else begin
                stateNext = ST_LOAD_INST_ADDR; // fetch next instruction         
             end
        end
        
        //////// Update ALU/MAC Output ////////
        ST_UPDATE_OUTPUT: begin
            alu_opcode = load_alu_output;
            mac_opcode = load_mac_output;
            if (inst_reg[15:12] == OP_OUT)
                stateNext = ST_LOAD_OUT_REG; // load output register
            else
                stateNext = ST_LOAD_WRITE_DATA; // write data to memory
        end
        
        //////// Load Output Register ////////
        ST_LOAD_OUT_REG: begin
            bus_active = 1'b1;
            bus_sel_in = decode_bus_sel; // drive write data onto the bus
            if (bus_delay == 1'b1) begin
                out_reg_en = 1'b1; // load write data to memory address register
                stateNext = ST_LOAD_INST_ADDR; // fetch next instruction
            end
        end
        
        //////// Error State ////////
        ST_ERROR: begin
            stateNext = ST_ERROR;
        end
        
        default: stateNext = ST_IDLE;
    endcase
    
end

endmodule
