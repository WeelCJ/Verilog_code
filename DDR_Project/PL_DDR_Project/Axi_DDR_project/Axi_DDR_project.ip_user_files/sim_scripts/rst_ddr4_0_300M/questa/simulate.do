onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib rst_ddr4_0_300M_opt

do {wave.do}

view wave
view structure
view signals

do {rst_ddr4_0_300M.udo}

run -all

quit -force
