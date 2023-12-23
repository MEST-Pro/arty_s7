// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Tue Nov 21 18:33:38 2023
// Host        : DESKTOP-JJ88F0M running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top fpga_rom -prefix
//               fpga_rom_ fpga_rom_sim_netlist.v
// Design      : fpga_rom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s25csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fpga_rom,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module fpga_rom
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [7:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.7096 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "fpga_rom.mem" *) 
  (* C_INIT_FILE_NAME = "fpga_rom.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  fpga_rom_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19520)
`pragma protect data_block
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
RQGuw1KgPX4XAf6e8z8pM6KDTqcKuD2oDXk=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
