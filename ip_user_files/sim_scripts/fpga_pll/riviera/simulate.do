onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+fpga_pll  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.fpga_pll xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {fpga_pll.udo}

run 1000ns

endsim

quit -force
