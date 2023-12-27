############MY_MAC.sdc#################

set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1ns

# Set the current design
current_design mest_pro

# Clock Creation 

create_clock -name "CLK100MHZ" -add -period 10 -waveform {0.0 5} [get_ports CLK100MHZ]

####################################################################

# Set Outputs external load 0.001pf   
# This is the input loading of your choosen output buffer

set_load 0.05 [all_outputs]    
#set_false_path -through i_reset_n
######################################################################

#Specified clock timing to be met with 10ps uncertainity


set_clock_uncertainty 1.0 [get_clocks CLK100MHZ]

#############################################################


