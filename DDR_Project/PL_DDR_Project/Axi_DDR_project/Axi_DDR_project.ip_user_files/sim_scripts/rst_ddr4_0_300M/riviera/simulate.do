onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+rst_ddr4_0_300M -L xil_defaultlib -L xpm -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_12 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.rst_ddr4_0_300M xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {rst_ddr4_0_300M.udo}

run -all

endsim

quit -force
