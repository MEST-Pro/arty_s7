## The following var should be changed as per the file name
set vars(FILE_NAME) asic_top
set vars(RPT_PATH) ./Reports
set vars(NETLIST_PATH) ./SynNetlist

set_db / .init_lib_search_path { /home/elsadek.2/Share/DICD_course_130nm/techFiles }

set_db / .library { sky130_fd_sc_hd__tt_025C_1v80.lib}


# ------> To preserve the modules  < ------------#

set_db / .boundary_opto false
set_db / .auto_ungroup {none}


read_hdl -language v2001 -f src_list
read_hdl -sv /home/stasi.3/Mest_proj/arty_s7/sources/common/sap1_header.vh

elaborate asic_top

#Read constraints
read_sdc ../../constrs/new/asic_sdc.sdc


set_db / .syn_generic_effort high
syn_generic

set_db / .syn_map_effort high
syn_map 

write_hdl -generic > $vars(NETLIST_PATH)/mest_pro_Syn_Gen.v
write_hdl > $vars(NETLIST_PATH)/mest_pro_Syn.v
write_sdf > $vars(NETLIST_PATH)/$vars(FILE_NAME).sdf

report summary > $vars(RPT_PATH)/$vars(FILE_NAME)_summary.rpt

report timing -path_type full_clock -max_paths 100 -nworst 10   > $vars(RPT_PATH)/$vars(FILE_NAME)_timing_worst.rpt

report timing -lint -verbose > $vars(RPT_PATH)/$vars(FILE_NAME)_lint.rpt

report clocks > $vars(RPT_PATH)/$vars(FILE_NAME)_clocks.rpt

report_power > $vars(RPT_PATH)/$vars(FILE_NAME)_POWER.rpt

report area > $vars(RPT_PATH)/$vars(FILE_NAME)_AREA.rpt

report messages > $vars(RPT_PATH)/$vars(FILE_NAME).txt

