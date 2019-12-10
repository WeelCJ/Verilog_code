vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/microblaze_v10_0_7
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_12
vlib riviera/lmb_v10_v3_0_9
vlib riviera/lmb_bram_if_cntlr_v4_0_15
vlib riviera/blk_mem_gen_v8_4_1
vlib riviera/iomodule_v3_1_3

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap microblaze_v10_0_7 riviera/microblaze_v10_0_7
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_12 riviera/proc_sys_reset_v5_0_12
vmap lmb_v10_v3_0_9 riviera/lmb_v10_v3_0_9
vmap lmb_bram_if_cntlr_v4_0_15 riviera/lmb_bram_if_cntlr_v4_0_15
vmap blk_mem_gen_v8_4_1 riviera/blk_mem_gen_v8_4_1
vmap iomodule_v3_1_3 riviera/iomodule_v3_1_3

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"D:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v10_0_7 -93 \
"../../../ipstatic/hdl/microblaze_v10_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_0/sim/bd_9054_microblaze_I_0.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../ipstatic/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_12 -93 \
"../../../ipstatic/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_1/sim/bd_9054_rst_0_0.vhd" \

vcom -work lmb_v10_v3_0_9 -93 \
"../../../ipstatic/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_2/sim/bd_9054_ilmb_0.vhd" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_3/sim/bd_9054_dlmb_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_15 -93 \
"../../../ipstatic/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_4/sim/bd_9054_dlmb_cntlr_0.vhd" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_5/sim/bd_9054_ilmb_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_1  -v2k5 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_6/sim/bd_9054_lmb_bram_I_0.v" \

vcom -work xil_defaultlib -93 \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_7/sim/bd_9054_second_dlmb_cntlr_0.vhd" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_8/sim/bd_9054_second_ilmb_cntlr_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_9/sim/bd_9054_second_lmb_bram_I_0.v" \

vcom -work iomodule_v3_1_3 -93 \
"../../../ipstatic/hdl/iomodule_v3_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/ip/ip_10/sim/bd_9054_iomodule_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/bd_0/sim/bd_9054.v" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_0/sim/ddr4_0_microblaze_mcs.v" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy_behav.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/iob/ddr4_phy_v2_2_iob_byte.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/iob/ddr4_phy_v2_2_iob.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/clocking/ddr4_phy_v2_2_pll.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_tristate_wrapper.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_riuor_wrapper.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_control_wrapper.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_byte_wrapper.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_bitslice_wrapper.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/phy/ddr4_0_phy_ddr4.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/ip_top/ddr4_0_phy.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_axi_tg_top.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_axi_opcode_gen.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_boot_mode_gen.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_custom_mode_gen.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_prbs_mode_gen.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_axi_wrapper.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_data_chk.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/axi_tg/ddr4_v2_2_data_gen.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/glbl.v" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/ip_1/rtl/map" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top" "+incdir+../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model/arch_package.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model/interface.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/ddr4_model/proj_package.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_wtr.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ref.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_rd_wr.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_periodic.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_group.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_merge_enc.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_gen.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_fi_xor.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_dec_fix.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc_buf.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ecc.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_ctl.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_cmd_mux_c.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_cmd_mux_ap.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_p.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_mux_p.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_c.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_arb_a.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_act_timer.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc_act_rank.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/controller/ddr4_v2_2_mc.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui_wr_data.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui_rd_data.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui_cmd.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ui/ddr4_v2_2_ui.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_ar_channel.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_aw_channel.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_b_channel.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_cmd_arbiter.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_cmd_fsm.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_cmd_translator.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_fifo.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_incr_cmd.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_r_channel.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_w_channel.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_wr_cmd_fsm.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_wrap_cmd.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_a_upsizer.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_register_slice.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axi_upsizer.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_axic_register_slice.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_carry_and.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_carry_latch_and.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_carry_latch_or.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_carry_or.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_command_fifo.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_comparator.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_comparator_sel.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_comparator_sel_static.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_r_upsizer.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi/ddr4_v2_2_w_upsizer.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi_ctrl/ddr4_v2_2_axi_ctrl_addr_decode.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi_ctrl/ddr4_v2_2_axi_ctrl_read.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi_ctrl/ddr4_v2_2_axi_ctrl_reg_bank.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi_ctrl/ddr4_v2_2_axi_ctrl_reg.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi_ctrl/ddr4_v2_2_axi_ctrl_top.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/axi_ctrl/ddr4_v2_2_axi_ctrl_write.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/clocking/ddr4_v2_2_infrastructure.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_xsdb_bram.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_write.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_wr_byte.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_wr_bit.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_sync.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_read.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_rd_en.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_pi.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_mc_odt.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_debug_microblaze.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_cplx_data.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_cplx.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_config_rom.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_addr_decode.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_top.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal_xsdb_arbiter.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_cal.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_chipscope_xsdb_slave.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_v2_2_dp_AB9.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top/ddr4_0.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top/ddr4_0_ddr4.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/ip_top/ddr4_0_ddr4_mem_intfc.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/rtl/cal/ddr4_0_ddr4_cal_riu.sv" \
"../../../../Axi_DDR_project.srcs/sources_1/ip/ddr4_0/tb/microblaze_mcs_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

