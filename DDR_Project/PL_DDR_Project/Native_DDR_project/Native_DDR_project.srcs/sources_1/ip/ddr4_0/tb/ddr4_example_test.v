`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 14:53:39
// Design Name: 
// Module Name: ddr4_example_test
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


module ddr4_example_test();

    reg                  sys_rst;
    reg clk_50M;
    reg [27 : 0] start_wr_addr, start_rd_addr;
    reg wr_addr_en, rd_addr_en;
    reg [9 : 0] wr_trans_len, rd_trans_len;
    reg [1023 : 0] wr_data;
    
    wire [15 : 0] rd_data;

    wire                 c0_ddr4_act_n;
    wire  [16:0]          c0_ddr4_adr;
    wire  [1:0]          c0_ddr4_ba;
    wire  [0:0]          c0_ddr4_bg;
    wire  [0:0]           c0_ddr4_cke;
    wire  [0:0]           c0_ddr4_odt;
    wire  [0:0]            c0_ddr4_cs_n;

    wire  [0:0]  c0_ddr4_ck_t_int;
    wire  [0:0]  c0_ddr4_ck_c_int;

    wire                 c0_ddr4_reset_n;

    wire  [1:0]          c0_ddr4_dm_dbi_n;
    wire  [15:0]          c0_ddr4_dq;
    wire  [1:0]          c0_ddr4_dqs_c;
    wire  [1:0]          c0_ddr4_dqs_t;


    reg [0:0]  en_model;

integer i;
//**************************************************************************//
// Reset Generation
//**************************************************************************//
    initial begin
        wr_addr_en = 0;
        rd_addr_en = 0;
        wr_trans_len = 0;
        rd_trans_len = 0;
        sys_rst = 1'b0;
        #200;
        sys_rst = 1'b1;
        en_model = 1'b0; 
        #5 en_model = 1'b1;
        #200;
        sys_rst = 1'b0;
        #5599595;
        start_wr_addr = 28'd1280;
        wr_trans_len = 60;
        wr_addr_en = 1;
        wr_data = {{8{16'hf11f}},{8{16'he11e}},{8{16'hd11d}},{8{16'hc11c}},{8{16'hb11b}},{8{16'ha11a}},{8{16'h9119}},{8{16'h8118}}};
        #10000;
        wr_addr_en = 0;
    
        for(i = 0; i < 60; i = i + 1) begin                 
            #160000;
            wr_data = wr_data + 1024'd3245;
            #10000;
        end

        #100000;
        rd_addr_en = 1;
        rd_trans_len = 60;
        start_rd_addr = 28'd1280;   
        #10000;
        rd_addr_en = 0;

        for(i = 0; i < 120; i = i + 1) begin 
            #160000;
            #10000;
        end 
        $stop;   
    end
//**************************************************************************//
// Clock Generation
//**************************************************************************//

        initial
            clk_50M = 1'b1;
        always
            clk_50M = #(10000) ~clk_50M;


//===========================================================================
//                         FPGA Memory Controller instantiation
//===========================================================================

ddr_example uut1(
    .sys_rst           (sys_rst),
    .wr_addr_en        (wr_addr_en),
    .rd_addr_en        (rd_addr_en),
    .start_wr_addr     (start_wr_addr),
    .start_rd_addr     (start_wr_addr),
    .wr_trans_len      (wr_trans_len),
    .rd_trans_len      (rd_trans_len),
    // .read_idle         (read_idle),
    // .read_done         (read_done),
    .clk_50M           (clk_50M),
    .wr_data           (wr_data),
    .rd_data           (rd_data),

    .c0_ddr4_act_n          (c0_ddr4_act_n),
    .c0_ddr4_adr            (c0_ddr4_adr),
    .c0_ddr4_ba             (c0_ddr4_ba),
    .c0_ddr4_bg             (c0_ddr4_bg),
    .c0_ddr4_cke            (c0_ddr4_cke),
    .c0_ddr4_odt            (c0_ddr4_odt),
    .c0_ddr4_cs_n           (c0_ddr4_cs_n),
    .c0_ddr4_ck_t           (c0_ddr4_ck_t_int),
    .c0_ddr4_ck_c           (c0_ddr4_ck_c_int),
    .c0_ddr4_reset_n        (c0_ddr4_reset_n),
    .c0_ddr4_dm_dbi_n       (c0_ddr4_dm_dbi_n),
    .c0_ddr4_dq             (c0_ddr4_dq),
    .c0_ddr4_dqs_c          (c0_ddr4_dqs_c),
    .c0_ddr4_dqs_t          (c0_ddr4_dqs_t)
     );

sdrmddr4 uut2(
    .c0_ddr4_act_n   (c0_ddr4_act_n),
    .c0_ddr4_adr     (c0_ddr4_adr),
    .c0_ddr4_ba      (c0_ddr4_ba),
    .c0_ddr4_bg      (c0_ddr4_bg),
    .c0_ddr4_cke     (c0_ddr4_cke),
    .c0_ddr4_odt     (c0_ddr4_odt),
    .c0_ddr4_cs_n    (c0_ddr4_cs_n),
    .c0_ddr4_ck_t_int(c0_ddr4_ck_t_int),
    .c0_ddr4_ck_c_int(c0_ddr4_ck_c_int),
    .c0_ddr4_reset_n (c0_ddr4_reset_n),
    .c0_ddr4_dm_dbi_n(c0_ddr4_dm_dbi_n),
    .c0_ddr4_dq      (c0_ddr4_dq),
    .c0_ddr4_dqs_c   (c0_ddr4_dqs_c),
    .c0_ddr4_dqs_t   (c0_ddr4_dqs_t),
    .en_model        (en_model)
    );

endmodule
