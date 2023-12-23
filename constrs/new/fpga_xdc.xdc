# Reset
# set_property -dict { PACKAGE_PIN C18 IOSTANDARD LVCMOS33 } [get_ports { RESET }];

# Oscillator (ASFLM-100.000MHZ-LR-T)
set_property -dict { PACKAGE_PIN R2 IOSTANDARD SSTL135 } [get_ports { OSC100MHZ }];
create_clock -period 10.000 -waveform {0.000 5.000} -add [get_ports { OSC100MHZ }] # define clock
set_input_jitter [get_clocks -of_objects [get_ports OSC100MHZ]] 0.100 # set clock jitter

# Oscillator
set_property -dict { PACKAGE_PIN F14 IOSTANDARD LVCMOS33 } [get_ports { OSC12MHZ }];
create_clock -add -name sys_clk_pin -period 83.333 -waveform {0 41.667} [get_ports OSC12MHZ] # define clock
set_input_jitter [get_clocks -of_objects [get_ports OSC12MHZ]] 0.833 # set clock jitter

# Buttons
set_property -dict { PACKAGE_PIN G15 IOSTANDARD LVCMOS33 } [get_ports { BTN[0] }];
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports { BTN[1] }];
set_property -dict { PACKAGE_PIN J16 IOSTANDARD LVCMOS33 } [get_ports { BTN[2] }];
set_property -dict { PACKAGE_PIN H13 IOSTANDARD LVCMOS33 } [get_ports { BTN[3] }];

# Slide Switches
set_property -dict { PACKAGE_PIN H14 IOSTANDARD LVCMOS33 } [get_ports { SW[0] }];
set_property -dict { PACKAGE_PIN H18 IOSTANDARD LVCMOS33 } [get_ports { SW[1] }];
set_property -dict { PACKAGE_PIN G18 IOSTANDARD LVCMOS33 } [get_ports { SW[2] }];
set_property -dict { PACKAGE_PIN M5  IOSTANDARD SSTL135 }  [get_ports { SW[3] }];

# Tri-Color LED
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { RLED[0] }];
set_property -dict { PACKAGE_PIN G17 IOSTANDARD LVCMOS33 } [get_ports { GLED[0] }];
set_property -dict { PACKAGE_PIN F15 IOSTANDARD LVCMOS33 } [get_ports { BLED[0] }];
set_property -dict { PACKAGE_PIN E15 IOSTANDARD LVCMOS33 } [get_ports { RLED[1] }];
set_property -dict { PACKAGE_PIN F18 IOSTANDARD LVCMOS33 } [get_ports { GLED[1] }];
set_property -dict { PACKAGE_PIN E14 IOSTANDARD LVCMOS33 } [get_ports { BLED[1] }];

# User LED
set_property -dict { PACKAGE_PIN E18 IOSTANDARD LVCMOS33 } [get_ports { LED[0] }];
set_property -dict { PACKAGE_PIN F13 IOSTANDARD LVCMOS33 } [get_ports { LED[1] }];
set_property -dict { PACKAGE_PIN E13 IOSTANDARD LVCMOS33 } [get_ports { LED[2] }];
set_property -dict { PACKAGE_PIN H15 IOSTANDARD LVCMOS33 } [get_ports { LED[3] }];

# UART
# set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports { UART_RX }];
set_property -dict { PACKAGE_PIN R12 IOSTANDARD LVCMOS33 } [get_ports { UART_TX }];

# Quad SPI
# set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports { QSPI_CS_N }];
# set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports { QSPI_IO[0] }];
# set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports { QSPI_IO[1] }];
# set_property -dict { PACKAGE_PIN L14 IOSTANDARD LVCMOS33 } [get_ports { QSPI_IO[2] }];
# set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS33 } [get_ports { QSPI_IO[3] }];

# SPI
# set_property -dict { PACKAGE_PIN K14 IOSTANDARD LVCMOS33 } [get_ports { SPI_MISO }];
# set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { SPI_MOSI }];
# set_property -dict { PACKAGE_PIN G16 IOSTANDARD LVCMOS33 } [get_ports { SPI_SCLK }];
# set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { SPI_SS }];

# I2C
# set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports { I2C_SCL }];
# set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { I2C_SDA }];

# Configuration Options
# set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
# set_property CONFIG_VOLTAGE 3.3 [current_design]
# set_property CFGBVS VCCO [current_design]
# set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
# set_property CONFIG_MODE SPIx4 [current_design]

# SW3 is assigned to a pin M5 in the 1.35v bank. This pin can also be used as
# the VREF for BANK 34. To be able to use this pin as an ordinary I/O the
# following property must be set to enable an internal VREF for BANK 34.
# Since a 1.35v supply is being used the internal reference is set to half that
# value (i.e. 0.675v).
set_property INTERNAL_VREF 0.675 [get_iobanks 34]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]