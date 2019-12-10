`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 14:52:51
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

module ddr_example #
  (
    parameter nCK_PER_CLK           = 4,   // This parameter is controllerwise
    parameter         APP_DATA_WIDTH          = 128, // This parameter is controllerwise
    parameter         APP_MASK_WIDTH          = 16,  // This parameter is controllerwise

  `ifdef SIMULATION_MODE
    parameter SIMULATION            = "TRUE" 
  `else
    parameter SIMULATION            = "FALSE"
  `endif

  )
   (
    input                 sys_rst, //Common port for all controllers
    input wr_addr_en, rd_addr_en, write_en,
    input [27 : 0] start_wr_addr, start_rd_addr,
    input [9 : 0] wr_trans_len, rd_trans_len,

    input clk_50M,
    input [1023 : 0] wr_data,
    output [15 : 0] rd_data,

//    output                  c0_init_calib_complete,
    output                  c0_ddr4_act_n,
    output [16:0]           c0_ddr4_adr,
    output [1:0]            c0_ddr4_ba,      //bank选择信号
    output [0:0]            c0_ddr4_bg,      
    output [0:0]            c0_ddr4_cke,
    output [0:0]            c0_ddr4_odt,
    output [0:0]            c0_ddr4_cs_n,    //rank选择信号，几bit就有几个rank，一般是多个bank组成一个rank，为了匹配数据总线
    output [0:0]            c0_ddr4_ck_t,
    output [0:0]            c0_ddr4_ck_c,
    output                  c0_ddr4_reset_n,
    inout  [1:0]            c0_ddr4_dm_dbi_n,
    inout  [15:0]           c0_ddr4_dq,
    inout  [1:0]            c0_ddr4_dqs_t,
    inout  [1:0]            c0_ddr4_dqs_c
    );


  localparam  APP_ADDR_WIDTH = 28;
  localparam  MEM_ADDR_ORDER = "ROW_COLUMN_BANK";
  localparam DBG_WR_STS_WIDTH      = 32;
  localparam DBG_RD_STS_WIDTH      = 32;
  localparam ECC                   = "OFF";

  wire [APP_ADDR_WIDTH-1:0]            c0_ddr4_app_addr;
  wire [2:0]                           c0_ddr4_app_cmd;
  wire                                 c0_ddr4_app_en;
  wire [APP_DATA_WIDTH-1:0]            c0_ddr4_app_wdf_data;
  wire                                 c0_ddr4_app_wdf_end;
  // wire [APP_MASK_WIDTH-1:0]            c0_ddr4_app_wdf_mask;
  wire                                 c0_ddr4_app_wdf_wren;
  wire [APP_DATA_WIDTH-1:0]            c0_ddr4_app_rd_data;
  wire                                 c0_ddr4_app_rd_data_end;
  wire                                 c0_ddr4_app_rd_data_valid;
  wire                                 c0_ddr4_app_rdy;
  wire                                 c0_ddr4_app_wdf_rdy;
  wire                                 c0_ddr4_clk;
  wire                                 c0_ddr4_rst;

  wire clk_100M;
  wire clk_300M;
  wire                   c0_sys_clk_p;
  wire                   c0_sys_clk_n;

assign c0_sys_clk_p = clk_300M;
assign c0_sys_clk_n = ~clk_300M;

wire c0_ddr4_reset_n_int;
  assign c0_ddr4_reset_n = c0_ddr4_reset_n_int;


//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

  // user design top is one instance for all controllers
ddr4_0 uut1
  (
   .sys_rst           (sys_rst),

   .c0_sys_clk_p                   (c0_sys_clk_p),
   .c0_sys_clk_n                   (c0_sys_clk_n),
//   .c0_init_calib_complete         (c0_init_calib_complete),
   .c0_ddr4_act_n          (c0_ddr4_act_n),
   .c0_ddr4_adr            (c0_ddr4_adr),
   .c0_ddr4_ba             (c0_ddr4_ba),
   .c0_ddr4_bg             (c0_ddr4_bg),
   .c0_ddr4_cke            (c0_ddr4_cke),
   .c0_ddr4_odt            (c0_ddr4_odt),
   .c0_ddr4_cs_n           (c0_ddr4_cs_n),
   .c0_ddr4_ck_t           (c0_ddr4_ck_t),
   .c0_ddr4_ck_c           (c0_ddr4_ck_c),
   .c0_ddr4_reset_n        (c0_ddr4_reset_n_int),

   .c0_ddr4_dm_dbi_n       (c0_ddr4_dm_dbi_n),
   .c0_ddr4_dq             (c0_ddr4_dq),
   .c0_ddr4_dqs_c          (c0_ddr4_dqs_c),
   .c0_ddr4_dqs_t          (c0_ddr4_dqs_t),

   .c0_ddr4_ui_clk                (c0_ddr4_clk),
   .c0_ddr4_ui_clk_sync_rst       (c0_ddr4_rst),
   .dbg_clk                       (),

   .c0_ddr4_app_addr              (c0_ddr4_app_addr),                       //操作地址，按照结构从高位到低位是 rank + row + column + bank
   .c0_ddr4_app_cmd               (c0_ddr4_app_cmd),                        //该输入选择当前请求的命令，一般写是000，读是001
   .c0_ddr4_app_en                (c0_ddr4_app_en),                         //这是app_addr []，app_cmd [2：0]，app_sz和app_hi_pri输入的高有效选通
   .c0_ddr4_app_hi_pri            (1'b0),                                    //表明当前选择是高优先级别的，默认为0
   .c0_ddr4_app_wdf_data          (c0_ddr4_app_wdf_data),
   .c0_ddr4_app_wdf_end           (c0_ddr4_app_wdf_end),                    //这个高电平有效输入表明当前时钟周期是app_wdf_data []上输入数据的最后一个周期
   .c0_ddr4_app_wdf_mask          (16'b0),                                 //数据掩码，默认设置为0
   .c0_ddr4_app_wdf_wren          (c0_ddr4_app_wdf_wren),
   .c0_ddr4_app_rd_data           (c0_ddr4_app_rd_data),
   .c0_ddr4_app_rd_data_end       (c0_ddr4_app_rd_data_end),                //该高电平有效输出表明当前时钟周期是app_rd_data []上输出数据的最后一个周期
   .c0_ddr4_app_rd_data_valid     (c0_ddr4_app_rd_data_valid),
   .c0_ddr4_app_rdy               (c0_ddr4_app_rdy),                       //此输出表明UI已准备好接受命令。如果在启用app_en时取消断言信号，则必须重试当前的app_cmd和app_addr，直到app_rdy被声明为止
   .c0_ddr4_app_wdf_rdy           (c0_ddr4_app_wdf_rdy),                   //该输出表明写入数据FIFO已准备好接收数据。写入数据在app_wdf_rdy = 1'b1 和app_wdf_wren = 1'b1 时被接受
  
  // Debug Port
  .dbg_bus         ()                                             

  );

//***************************************************************************
// The example testbench module instantiated below drives traffic (patterns)
// on the application interface of the memory controller
//***************************************************************************
// In DDR4, there are two test generators (TG) available for user to select:
//  1) Simple Test Generator (STG) √
//  2) Advanced Test Generator (ATG)
// 

data_interactionddr4 #
  (
   .SIMULATION     (SIMULATION),
   .APP_DATA_WIDTH (APP_DATA_WIDTH),
   .APP_ADDR_WIDTH (APP_ADDR_WIDTH),
   .MEM_ADDR_ORDER (MEM_ADDR_ORDER)
   )
  uut2
    (
     .ui_clk                                  (clk_100M),
     .ddr_clk                                 (c0_ddr4_clk),
     .rst                                     (~c0_ddr4_rst),
     .rd_addr_en                              (rd_addr_en),
     .wr_addr_en                              (wr_addr_en),
     .write_en                                (write_en),
     .start_wr_addr                           (start_wr_addr),
     .start_rd_addr                           (start_rd_addr),
     .wr_data                                 (wr_data),
     .rd_data                                 (rd_data),
     .wr_trans_len                            (wr_trans_len),
     .rd_trans_len                            (rd_trans_len),

     .app_rdy                                 (c0_ddr4_app_rdy),
//.init_calib_complete                     (c0_init_calib_complete),
//     .app_rd_data_end                         (c0_ddr4_app_rd_data_end), 
     .app_rd_data_valid                       (c0_ddr4_app_rd_data_valid),
     .app_rd_data                             (c0_ddr4_app_rd_data),
     .app_wdf_rdy                             (c0_ddr4_app_wdf_rdy),
     .app_en                                  (c0_ddr4_app_en),
     .app_cmd                                 (c0_ddr4_app_cmd),
     .app_addr                                (c0_ddr4_app_addr),
     .app_wdf_wren                            (c0_ddr4_app_wdf_wren),
     .app_wdf_end                             (c0_ddr4_app_wdf_end),
//     .app_wdf_mask                            (c0_ddr4_app_wdf_mask),
     .app_wdf_data                            (c0_ddr4_app_wdf_data)
  );

clk_wiz_0 uut3 (
  // Clock out ports
  .clk_out1(clk_100M),     // output clk_out1
  .clk_out2(clk_300M),     // output clk_out2
  // Status and control signals
  .locked(),       // output locked
  // Clock in ports
  .clk_in1(clk_50M)
);      // input clk_in1   

endmodule
