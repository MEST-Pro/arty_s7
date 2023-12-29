onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/i_CLK100MHZ
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/BTN
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/SW
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/RLED
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/GLED
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/BLED
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/LED
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/out_reg_data_out
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/clk100MHz
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pll_lock
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pll_lock_reg
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pll_reset
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/asic_pll_ctr
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/a_reset
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/s_reset
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/rst100MHz
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pc_reset
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pc_load
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pc_increment
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pc_out_of_range
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pc_load_data
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/pc_counter
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/addr_reg_en
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/addr_reg_data_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/addr_reg_data_out
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/data_reg_en
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/data_reg_data_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/data_reg_data_out
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/mem_wen
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/mem_addr
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/mem_wdata
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/mem_rdata
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/inst_reg_en
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/inst_reg_data_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/inst_reg_data_out
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/alu_acc_zero
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/alu_acc_overflow
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/alu_opcode
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/alu_data_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/alu_data_out
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/mac_opcode
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/mac_data_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/mac_data_out
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/out_reg_en
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/out_reg_data_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/bus_data_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/bus_sel_in
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/bus_data_out
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/error_state
add wave -noupdate -expand -group mest_pro_top /tb_asic_top/dut/mest_pro/ctrl_data_out
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/clk
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/a_reset_n
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/start
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/alu_acc_overflow
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/alu_acc_zero
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/inst_reg
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/pc_out_of_range
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/pc_reset
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/pc_load
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/pc_increment
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/error_state
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/addr_reg_en
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/data_reg_en
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/mem_wen
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/inst_reg_en
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/alu_opcode
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/mac_opcode
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/out_reg_en
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/bus_sel_in
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/data_out
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/stateReg
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/stateNext
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/bus_delay
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/bus_active
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/bus_shift_reg
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/rom_reset
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/rom_enable
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/rom_addr
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/rom_rdata
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/rom_delay
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/rom_shift_reg
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/startReg
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/decode_state
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/decode_alu_opcode
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/decode_mac_opcode
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/load_alu_output
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/load_mac_output
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/load_alu_input
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/load_mac_input
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/decode_bus_sel
add wave -noupdate -expand -group cpu_controller /tb_asic_top/dut/mest_pro/cpu_controller/decode_branch
add wave -noupdate -expand -group asic_rom /tb_asic_top/dut/mest_pro/cpu_controller/genblk1/sap1_program_rom/clka
add wave -noupdate -expand -group asic_rom /tb_asic_top/dut/mest_pro/cpu_controller/genblk1/sap1_program_rom/ena
add wave -noupdate -expand -group asic_rom /tb_asic_top/dut/mest_pro/cpu_controller/genblk1/sap1_program_rom/addra
add wave -noupdate -expand -group asic_rom /tb_asic_top/dut/mest_pro/cpu_controller/genblk1/sap1_program_rom/douta
add wave -noupdate -expand -group asic_rom /tb_asic_top/dut/mest_pro/cpu_controller/genblk1/sap1_program_rom/ROM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {39833 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 230
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {388982 ns}
