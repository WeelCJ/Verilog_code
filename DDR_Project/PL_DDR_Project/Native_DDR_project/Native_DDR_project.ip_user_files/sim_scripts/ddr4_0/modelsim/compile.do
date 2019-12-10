vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/microblaze_v10_0_7
vlib modelsim_lib/msim/lib_cdc_v1_0_2
vlib modelsim_lib/msim/proc_sys_reset_v5_0_12
vlib modelsim_lib/msim/lmb_v10_v3_0_9
vlib modelsim_lib/msim/lmb_bram_if_cntlr_v4_0_15
vlib modelsim_lib/msim/blk_mem_gen_v8_4_1
vlib modelsim_lib/msim/iomodule_v3_1_3

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap microblaze_v10_0_7 modelsim_lib/msim/microblaze_v10_0_7
vmap lib_cdc_v1_0_2 modelsim_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_12 modelsim_lib/msim/proc_sys_reset_v5_0_12
vmap lmb_v10_v3_0_9 modelsim_lib/msim/lmb_v10_v3_0_9
vmap lmb_bram_if_cntlr_v4_0_15 modelsim_lib/msim/lmb_bram_if_cntlr_v4_0_15
vmap blk_mem_gen_v8_4_1 modelsim_lib/msim/blk_mem_gen_v8_4_1
vmap iomodule_v3_1_3 modelsim_lib/msim/iomodule_v3_1_3

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"D:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v10_0_7 -64 -93 \
"../../../ipstatic/hdl/microblaze_v10_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_0/sim/bd_9054_microblaze_I_0.vhd" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../ipstatic/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_12 -64 -93 \
"../../../ipstatic/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_1/sim/bd_9054_rst_0_0.vhd" \

vcom -work lmb_v10_v3_0_9 -64 -93 \
"../../../ipstatic/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_2/sim/bd_9054_ilmb_0.vhd" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_3/sim/bd_9054_dlmb_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_15 -64 -93 \
"../../../ipstatic/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_4/sim/bd_9054_dlmb_cntlr_0.vhd" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_5/sim/bd_9054_ilmb_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_1 -64 -incr "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_6/sim/bd_9054_lmb_bram_I_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_7/sim/bd_9054_second_dlmb_cntlr_0.vhd" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_8/sim/bd_9054_second_ilmb_cntlr_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_9/sim/bd_9054_second_lmb_bram_I_0.v" \

vcom -work iomodule_v3_1_3 -64 -93 \
"../../../ipstatic/hdl/iomodule_v3_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_10/sim/bd_9054_iomodule_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/sim/bd_9054.v" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_0/sim/ddr4_0_microblaze_mcs.v" \

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy_behav.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/iob/ddr4_phy_v2_2_iob_byte.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/iob/ddr4_phy_v2_2_iob.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/clocking/ddr4_phy_v2_2_pll.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_tristate_wrapper.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_riuor_wrapper.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_control_wrapper.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_byte_wrapper.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_bitslice_wrapper.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/phy/ddr4_0_phy_ddr4.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/ip_top/ddr4_0_phy.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_wtr.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ref.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_rd_wr.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_periodic.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_group.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_merge_enc.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_gen.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_fi_xor.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_dec_fix.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_buf.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ctl.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_cmd_mux_c.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_cmd_mux_ap.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_p.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_mux_p.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_c.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_a.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_act_timer.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_act_rank.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui_wr_data.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui_rd_data.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui_cmd.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/clocking/ddr4_v2_2_infrastructure.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_xsdb_bram.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_write.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_wr_byte.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_wr_bit.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_sync.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_read.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_rd_en.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_pi.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_mc_odt.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_debug_microblaze.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_cplx_data.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_cplx.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_config_rom.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_addr_decode.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_top.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_xsdb_arbiter.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_chipscope_xsdb_slave.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_dp_AB9.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top/ddr4_0.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top/ddr4_0_ddr4.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top/ddr4_0_ddr4_mem_intfc.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_0_ddr4_cal_riu.sv" \
"../../../../Native_DDR_project.srcs/sources_1/ip/ddr4_0/tb/microblaze_mcs_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

