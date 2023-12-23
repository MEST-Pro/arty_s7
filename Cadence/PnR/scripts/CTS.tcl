setCTSMode -routeTopPreferredLayer 4 \
   -routeLeafTopPreferredLayer 4 \
   -routeBottomPreferredLayer 3 \
   -routeLeafBottomPreferredLayer 3 

set_ccopt_mode  -integration "native" \
   -cts_inverter_cells "sky130_fd_sc_hd__clkinv_1  sky130_fd_sc_hd__clkinv_2 sky130_fd_sc_hd__clkinv_4 sky130_fd_sc_hd__clkinv_8" \
   -cts_buffer_cells "sky130_fd_sc_hd__clkbuf_1  sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8" \
   -cts_use_inverters false \
   -ccopt_modify_clock_latency false \
   -cts_target_slew 50 \
   -route_top_top_preferred_layer 4 \
   -route_top_bottom_preferred_layer 3

create_ccopt_clock_tree_spec
ccopt_design -outDir RPT/cts -prefix cts
