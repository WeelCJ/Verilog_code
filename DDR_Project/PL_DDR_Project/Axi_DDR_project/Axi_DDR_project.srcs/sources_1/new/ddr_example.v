`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/03 23:23:44
// Design Name: 
// Module Name: ddr_example
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`ifdef MODEL_TECH
    `define SIMULATION_MODE
`elsif INCA
    `define SIMULATION_MODE
`elsif VCS
    `define SIMULATION_MODE
`elsif XILINX_SIMULATOR
    `define SIMULATION_MODE
`endif

module ddr_example #(
    // parameter nCK_PER_CLK           = 4,   // This parameter is controllerwise
    // parameter         APP_DATA_WIDTH          = 128, // This parameter is controllerwise
    // parameter         APP_MASK_WIDTH          = 16,  // This parameter is controllerwise
    // parameter C_AXI_ID_WIDTH                = 4,
    //                                           // Width of all master and slave ID signals.
    //                                           // # = >= 1.
    // parameter C_AXI_ADDR_WIDTH              = 29,
    //                                           // Width of S_AXI_AWADDR, S_AXI_ARADDR, M_AXI_AWADDR and
    //                                           // M_AXI_ARADDR for all SI/MI slots.
    //                                           // # = 32.
    // parameter C_AXI_DATA_WIDTH              = 128,
    //                                           // Width of WDATA and RDATA on SI slot.
    //                                           // Must be <= APP_DATA_WIDTH.
    //                                           // # = 32, 64, 128, 256.
    // parameter C_AXI_NBURST_SUPPORT   = 0,

  `ifdef SIMULATION_MODE
    parameter SIMULATION            = "TRUE" 
  `else
    parameter SIMULATION            = "FALSE"
  `endif

  )
   (
    input                 sys_rst, //Common port for all controllers
    input [28 : 0] start_wr_addr, start_rd_addr,
    input wr_addr_en, rd_addr_en,
    input clk_50M,
    input s_axis_tvalid,
    input s_axis_tlast,
    input [1023 : 0] s_axis_tdata,

//    output                  c0_init_calib_complete,
    output                  c0_ddr4_act_n,
    output [16:0]            c0_ddr4_adr,
    output [1:0]            c0_ddr4_ba,
    output [0:0]            c0_ddr4_bg,
    output [0:0]            c0_ddr4_cke,
    output [0:0]            c0_ddr4_odt,
    output [0:0]            c0_ddr4_cs_n,
    output [0:0]                c0_ddr4_ck_t,
    output [0:0]                c0_ddr4_ck_c,
    output                  c0_ddr4_reset_n,
    inout  [1:0]            c0_ddr4_dm_dbi_n,
    inout  [15:0]            c0_ddr4_dq,
    inout  [1:0]            c0_ddr4_dqs_t,
    inout  [1:0]            c0_ddr4_dqs_c
    );

    wire c0_ddr4_rst;
    wire c0_ddr4_ui_clk;
    reg c0_ddr4_aresetn;
    wire [3 : 0] c0_ddr4_s_axi_awid;            // input wire [3 : 0] c0_ddr4_s_axi_awid
    wire [28 : 0] c0_ddr4_s_axi_awaddr;        // input wire [28 : 0] c0_ddr4_s_axi_awaddr
    wire [7 : 0] c0_ddr4_s_axi_awlen;          // input wire [7 : 0] c0_ddr4_s_axi_awlen
    wire [2 : 0] c0_ddr4_s_axi_awsize;        // input wire [2 : 0] c0_ddr4_s_axi_awsize
    wire [1 : 0] c0_ddr4_s_axi_awburst;      // input wire [1 : 0] c0_ddr4_s_axi_awburst
//    wire [0 : 0] c0_ddr4_s_axi_awlock;        // input wire [0 : 0] c0_ddr4_s_axi_awlock
    wire [3 : 0] c0_ddr4_s_axi_awcache;      // input wire [3 : 0] c0_ddr4_s_axi_awcache
    wire [2 : 0] c0_ddr4_s_axi_awprot;        // input wire [2 : 0] c0_ddr4_s_axi_awprot
//    wire [3 : 0] c0_ddr4_s_axi_awqos;          // input wire [3 : 0] c0_ddr4_s_axi_awqos
    wire c0_ddr4_s_axi_awvalid;      // input wire c0_ddr4_s_axi_awvalid
    wire c0_ddr4_s_axi_awready;      // output wire c0_ddr4_s_axi_awready
    wire [127 : 0] c0_ddr4_s_axi_wdata;          // input wire [127 : 0] c0_ddr4_s_axi_wdata
    wire [15 : 0] c0_ddr4_s_axi_wstrb;          // input wire [15 : 0] c0_ddr4_s_axi_wstrb
    wire c0_ddr4_s_axi_wlast;          // input wire c0_ddr4_s_axi_wlast
    wire c0_ddr4_s_axi_wvalid;        // input wire c0_ddr4_s_axi_wvalid
    wire c0_ddr4_s_axi_wready;        // output wire c0_ddr4_s_axi_wready
    wire c0_ddr4_s_axi_bready;        // input wire c0_ddr4_s_axi_bready
    wire [3 : 0] c0_ddr4_s_axi_bid;              // output wire [3 : 0] c0_ddr4_s_axi_bid
    wire [1 : 0] c0_ddr4_s_axi_bresp;          // output wire [1 : 0] c0_ddr4_s_axi_bresp
    wire c0_ddr4_s_axi_bvalid;        // output wire c0_ddr4_s_axi_bvalid
    wire [3 : 0] c0_ddr4_s_axi_arid;            // input wire [3 : 0] c0_ddr4_s_axi_arid
    wire [28 : 0] c0_ddr4_s_axi_araddr;        // input wire [28 : 0] c0_ddr4_s_axi_araddr
    wire [7 : 0] c0_ddr4_s_axi_arlen;          // input wire [7 : 0] c0_ddr4_s_axi_arlen
    wire [2 : 0] c0_ddr4_s_axi_arsize;        // input wire [2 : 0] c0_ddr4_s_axi_arsize
    wire [1 : 0] c0_ddr4_s_axi_arburst;      // input wire [1 : 0] c0_ddr4_s_axi_arburst
//    wire [0 : 0] c0_ddr4_s_axi_arlock;        // input wire [0 : 0] c0_ddr4_s_axi_arlock
    wire [3 : 0] c0_ddr4_s_axi_arcache;      // input wire [3 : 0] c0_ddr4_s_axi_arcache
    wire [2 : 0] c0_ddr4_s_axi_arprot;        // input wire [2 : 0] c0_ddr4_s_axi_arprot
//    wire [3 : 0] c0_ddr4_s_axi_arqos;          // input wire [3 : 0] c0_ddr4_s_axi_arqos
    wire c0_ddr4_s_axi_arvalid;      // input wire c0_ddr4_s_axi_arvalid
    wire c0_ddr4_s_axi_arready;      // output wire c0_ddr4_s_axi_arready
    wire c0_ddr4_s_axi_rready;        // input wire c0_ddr4_s_axi_rready
    wire c0_ddr4_s_axi_rlast;          // output wire c0_ddr4_s_axi_rlast
    wire c0_ddr4_s_axi_rvalid;        // output wire c0_ddr4_s_axi_rvalid
    wire [1 : 0] c0_ddr4_s_axi_rresp;          // output wire [1 : 0] c0_ddr4_s_axi_rresp
    wire [3 : 0] c0_ddr4_s_axi_rid;              // output wire [3 : 0] c0_ddr4_s_axi_rid
    wire [127 : 0] c0_ddr4_s_axi_rdata;        // output wire [127 : 0] c0_ddr4_s_axi_rdata   

    // wire read_idle, read_done;
    wire s_axis_tready;

    wire m_axis_tvalid;
    wire m_axis_tlast;
    wire [15 : 0] m_axis_tdata;

    wire m_axis_tready;
    wire locked;
    wire clk_100M;
    wire clk_300M;
    wire                   c0_sys_clk_p;
    wire                   c0_sys_clk_n;

assign m_axis_tready = m_axis_tvalid;
assign c0_sys_clk_p = clk_300M;
assign c0_sys_clk_n = ~clk_300M;

wire c0_ddr4_reset_n_int;
  assign c0_ddr4_reset_n = c0_ddr4_reset_n_int;

always @(posedge c0_ddr4_ui_clk) begin
 c0_ddr4_aresetn <= ~c0_ddr4_rst;
end


ddr4_0 uut1 (
  .c0_init_calib_complete(),    // output wire c0_init_calib_complete
  .dbg_clk(),                                  // output wire dbg_clk
  .c0_sys_clk_p(c0_sys_clk_p),              // input wire c0_sys_clk_p
  .c0_sys_clk_n(c0_sys_clk_n),               // input wire c0_sys_clk_n
//  .c0_sys_clk_i(clk_300M),               // input wire c0_sys_clk_i  
  .dbg_bus(),                                // output wire [511 : 0] dbg_bus
  .c0_ddr4_adr(c0_ddr4_adr),                          // output wire [16 : 0] c0_ddr4_adr
  .c0_ddr4_ba(c0_ddr4_ba),                            // output wire [1 : 0] c0_ddr4_ba
  .c0_ddr4_cke(c0_ddr4_cke),                          // output wire [0 : 0] c0_ddr4_cke
  .c0_ddr4_cs_n(c0_ddr4_cs_n),                        // output wire [0 : 0] c0_ddr4_cs_n
  .c0_ddr4_dm_dbi_n(c0_ddr4_dm_dbi_n),                // inout wire [1 : 0] c0_ddr4_dm_dbi_n
  .c0_ddr4_dq(c0_ddr4_dq),                            // inout wire [15 : 0] c0_ddr4_dq
  .c0_ddr4_dqs_c(c0_ddr4_dqs_c),                      // inout wire [1 : 0] c0_ddr4_dqs_c
  .c0_ddr4_dqs_t(c0_ddr4_dqs_t),                      // inout wire [1 : 0] c0_ddr4_dqs_t
  .c0_ddr4_odt(c0_ddr4_odt),                          // output wire [0 : 0] c0_ddr4_odt
  .c0_ddr4_bg(c0_ddr4_bg),                            // output wire [0 : 0] c0_ddr4_bg
  .c0_ddr4_reset_n(c0_ddr4_reset_n),                  // output wire c0_ddr4_reset_n
  .c0_ddr4_act_n(c0_ddr4_act_n),                      // output wire c0_ddr4_act_n
  .c0_ddr4_ck_c(c0_ddr4_ck_c),                        // output wire [0 : 0] c0_ddr4_ck_c
  .c0_ddr4_ck_t(c0_ddr4_ck_t),                        // output wire [0 : 0] c0_ddr4_ck_t
  .c0_ddr4_ui_clk(c0_ddr4_ui_clk),                    // output wire c0_ddr4_ui_clk
  .c0_ddr4_ui_clk_sync_rst(c0_ddr4_rst),              // output wire c0_ddr4_ui_clk_sync_rst
  .c0_ddr4_aresetn(c0_ddr4_aresetn),                  // input wire c0_ddr4_aresetn
  .c0_ddr4_s_axi_awid(c0_ddr4_s_axi_awid),            // input wire [3 : 0] c0_ddr4_s_axi_awid
  .c0_ddr4_s_axi_awaddr(c0_ddr4_s_axi_awaddr),        // input wire [28 : 0] c0_ddr4_s_axi_awaddr
  .c0_ddr4_s_axi_awlen(c0_ddr4_s_axi_awlen),          // input wire [7 : 0] c0_ddr4_s_axi_awlen
  .c0_ddr4_s_axi_awsize(c0_ddr4_s_axi_awsize),        // input wire [2 : 0] c0_ddr4_s_axi_awsize
  .c0_ddr4_s_axi_awburst(c0_ddr4_s_axi_awburst),      // input wire [1 : 0] c0_ddr4_s_axi_awburst
  .c0_ddr4_s_axi_awlock(1'b0),                           // input wire [0 : 0] c0_ddr4_s_axi_awlock
  .c0_ddr4_s_axi_awcache(c0_ddr4_s_axi_awcache),      // input wire [3 : 0] c0_ddr4_s_axi_awcache
  .c0_ddr4_s_axi_awprot(c0_ddr4_s_axi_awprot),        // input wire [2 : 0] c0_ddr4_s_axi_awprot
  .c0_ddr4_s_axi_awqos(4'b0000),          // input wire [3 : 0] c0_ddr4_s_axi_awqos
  .c0_ddr4_s_axi_awvalid(c0_ddr4_s_axi_awvalid),      // input wire c0_ddr4_s_axi_awvalid
  .c0_ddr4_s_axi_awready(c0_ddr4_s_axi_awready),      // output wire c0_ddr4_s_axi_awready
  .c0_ddr4_s_axi_wdata(c0_ddr4_s_axi_wdata),          // input wire [127 : 0] c0_ddr4_s_axi_wdata
  .c0_ddr4_s_axi_wstrb(c0_ddr4_s_axi_wstrb),          // input wire [15 : 0] c0_ddr4_s_axi_wstrb
  .c0_ddr4_s_axi_wlast(c0_ddr4_s_axi_wlast),          // input wire c0_ddr4_s_axi_wlast
  .c0_ddr4_s_axi_wvalid(c0_ddr4_s_axi_wvalid),        // input wire c0_ddr4_s_axi_wvalid
  .c0_ddr4_s_axi_wready(c0_ddr4_s_axi_wready),        // output wire c0_ddr4_s_axi_wready
  .c0_ddr4_s_axi_bready(c0_ddr4_s_axi_bready),        // input wire c0_ddr4_s_axi_bready
  .c0_ddr4_s_axi_bid(c0_ddr4_s_axi_bid),              // output wire [3 : 0] c0_ddr4_s_axi_bid
  .c0_ddr4_s_axi_bresp(c0_ddr4_s_axi_bresp),          // output wire [1 : 0] c0_ddr4_s_axi_bresp
  .c0_ddr4_s_axi_bvalid(c0_ddr4_s_axi_bvalid),        // output wire c0_ddr4_s_axi_bvalid
  .c0_ddr4_s_axi_arid(c0_ddr4_s_axi_arid),            // input wire [3 : 0] c0_ddr4_s_axi_arid
  .c0_ddr4_s_axi_araddr(c0_ddr4_s_axi_araddr),        // input wire [28 : 0] c0_ddr4_s_axi_araddr
  .c0_ddr4_s_axi_arlen(c0_ddr4_s_axi_arlen),          // input wire [7 : 0] c0_ddr4_s_axi_arlen
  .c0_ddr4_s_axi_arsize(c0_ddr4_s_axi_arsize),        // input wire [2 : 0] c0_ddr4_s_axi_arsize
  .c0_ddr4_s_axi_arburst(c0_ddr4_s_axi_arburst),      // input wire [1 : 0] c0_ddr4_s_axi_arburst
  .c0_ddr4_s_axi_arlock(1'b0),        // input wire [0 : 0] c0_ddr4_s_axi_arlock
  .c0_ddr4_s_axi_arcache(c0_ddr4_s_axi_arcache),      // input wire [3 : 0] c0_ddr4_s_axi_arcache
  .c0_ddr4_s_axi_arprot(3'b0),        // input wire [2 : 0] c0_ddr4_s_axi_arprot
  .c0_ddr4_s_axi_arqos(4'b0000),          // input wire [3 : 0] c0_ddr4_s_axi_arqos
  .c0_ddr4_s_axi_arvalid(c0_ddr4_s_axi_arvalid),      // input wire c0_ddr4_s_axi_arvalid
  .c0_ddr4_s_axi_arready(c0_ddr4_s_axi_arready),      // output wire c0_ddr4_s_axi_arready
  .c0_ddr4_s_axi_rready(c0_ddr4_s_axi_rready),        // input wire c0_ddr4_s_axi_rready
  .c0_ddr4_s_axi_rlast(c0_ddr4_s_axi_rlast),          // output wire c0_ddr4_s_axi_rlast
  .c0_ddr4_s_axi_rvalid(c0_ddr4_s_axi_rvalid),        // output wire c0_ddr4_s_axi_rvalid
  .c0_ddr4_s_axi_rresp(c0_ddr4_s_axi_rresp),          // output wire [1 : 0] c0_ddr4_s_axi_rresp
  .c0_ddr4_s_axi_rid(c0_ddr4_s_axi_rid),              // output wire [3 : 0] c0_ddr4_s_axi_rid
  .c0_ddr4_s_axi_rdata(c0_ddr4_s_axi_rdata),          // output wire [127 : 0] c0_ddr4_s_axi_rdata
  .sys_rst(sys_rst)                                  // input wire sys_rst
);

data_write2ddr4 uut2(
    .m_axi_s2mm_aclk(c0_ddr4_ui_clk),
    .m_axi_s2mm_aresetn(~c0_ddr4_rst),
    .m_axi_s2mm_awid(c0_ddr4_s_axi_awid),
    .m_axi_s2mm_awaddr(c0_ddr4_s_axi_awaddr),
    .m_axi_s2mm_awlen(c0_ddr4_s_axi_awlen),
    .m_axi_s2mm_awsize(c0_ddr4_s_axi_awsize),
    .m_axi_s2mm_awburst(c0_ddr4_s_axi_awburst),
    .m_axi_s2mm_awprot(c0_ddr4_s_axi_awprot),
    .m_axi_s2mm_awcache(c0_ddr4_s_axi_awcache),
    .m_axi_s2mm_awvalid(c0_ddr4_s_axi_awvalid),
    .m_axi_s2mm_awready(c0_ddr4_s_axi_awready),
    .m_axi_s2mm_wdata(c0_ddr4_s_axi_wdata),
    .m_axi_s2mm_wstrb(c0_ddr4_s_axi_wstrb),
    .m_axi_s2mm_wlast(c0_ddr4_s_axi_wlast),
    .m_axi_s2mm_wvalid(c0_ddr4_s_axi_wvalid),
    .m_axi_s2mm_bid(c0_ddr4_s_axi_bid),
    .m_axi_s2mm_wready(c0_ddr4_s_axi_wready),
    .m_axi_s2mm_bresp(c0_ddr4_s_axi_bresp),
    .m_axi_s2mm_bvalid(c0_ddr4_s_axi_bvalid),
    .m_axi_s2mm_bready(c0_ddr4_s_axi_bready),
    .wr_addr_en(wr_addr_en),
    .start_wr_addr(start_wr_addr), 
//    .write_idle(write_idle),
//    .write_done(write_done),
    .s_axis_aclk(clk_100M),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tready(s_axis_tready)
    );

data_readfddr4 uut3(
    .m_axi_mm2s_aclk(c0_ddr4_ui_clk),              //AXI Stream Read 主接口类型
    .m_axi_mm2s_aresetn(~c0_ddr4_rst),
    .m_axi_mm2s_arid(c0_ddr4_s_axi_arid),
    .m_axi_mm2s_araddr(c0_ddr4_s_axi_araddr),
    .m_axi_mm2s_arlen(c0_ddr4_s_axi_arlen),
    .m_axi_mm2s_arsize(c0_ddr4_s_axi_arsize),
    .m_axi_mm2s_arburst(c0_ddr4_s_axi_arburst),
    .m_axi_mm2s_arcache(c0_ddr4_s_axi_arcache),
    .m_axi_mm2s_arvalid(c0_ddr4_s_axi_arvalid),
    .m_axi_mm2s_arready(c0_ddr4_s_axi_arready),
    .m_axi_mm2s_rid(c0_ddr4_s_axi_rid),
    .m_axi_mm2s_rdata(c0_ddr4_s_axi_rdata),
    .m_axi_mm2s_rresp(c0_ddr4_s_axi_rresp),
    .m_axi_mm2s_rlast(c0_ddr4_s_axi_rlast),
    .m_axi_mm2s_rvalid(c0_ddr4_s_axi_rvalid),
    .m_axi_mm2s_rready(c0_ddr4_s_axi_rready),
    .rd_addr_en(rd_addr_en),
    .start_rd_addr(start_rd_addr),
    // .read_idle(read_idle),
    // .read_done(read_done),
    .m_axis_aclk(clk_100M),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tlast(m_axis_tlast),
    .m_axis_tready(m_axis_tready)
    );

// rst_ddr4_0_300M uut4 (
//   .slowest_sync_clk(c0_ddr4_ui_clk),          // input wire slowest_sync_clk
//   .ext_reset_in(~c0_ddr4_rst),                  // input wire ext_reset_in
//   .aux_reset_in(),                  // input wire aux_reset_in
//   .mb_debug_sys_rst(),          // input wire mb_debug_sys_rst
//   .dcm_locked(locked),                      // input wire dcm_locked
//   .mb_reset(),                          // output wire mb_reset
//   .bus_struct_reset(),          // output wire [0 : 0] bus_struct_reset
//   .peripheral_reset(c0_ddr4_aresetn),          // output wire [0 : 0] peripheral_reset
//   .interconnect_aresetn(),  // output wire [0 : 0] interconnect_aresetn
//   .peripheral_aresetn()      // output wire [0 : 0] peripheral_aresetn
// );

clk_wiz_0 uut5 (
  // Clock out ports
  .clk_out1(clk_100M),     // output clk_out1
  .clk_out2(clk_300M),     // output clk_out2
  // Status and control signals
  .locked(locked),       // output locked
  // Clock in ports
  .clk_in1(clk_50M)
);      // input clk_in1    

endmodule
