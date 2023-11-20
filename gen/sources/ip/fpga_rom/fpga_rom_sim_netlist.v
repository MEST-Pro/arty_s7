// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Wed Nov 15 19:31:26 2023
// Host        : DESKTOP-JJ88F0M running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/kirkg/project_arty_s7/project_arty_s7.gen/sources_1/ip/fpga_rom/fpga_rom_sim_netlist.v
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19808)
`pragma protect data_block
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
qmXS+ZRP4dA9uWgFfLXI9dNmOiG2jjgC1gSGrD8=
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
