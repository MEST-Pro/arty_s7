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