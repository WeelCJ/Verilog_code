`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/04 17:27:38
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

module ddr4_example_test;

    reg                  sys_rst;
    reg [28 : 0] start_wr_addr, start_rd_addr;
    reg wr_addr_en, rd_addr_en;
    reg clk_50M;
    reg s_axis_tvalid;
    reg s_axis_tlast;
    reg [1023 : 0] s_axis_tdata;
    reg [9 : 0] write_burst_len, read_burst_len;

    wire write_done, read_done;

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
        s_axis_tvalid = 0;
        sys_rst = 1'b0;
        #200;
        sys_rst = 1'b1;
        en_model = 1'b0; 
        #5 en_model = 1'b1;
        #200;
        sys_rst = 1'b0;
        #5599595;
        start_wr_addr = 29'd128;
        write_burst_len = 10'd480;
        wr_addr_en = 1;
        s_axis_tvalid = 1;
        s_axis_tdata = {{8{16'hf11f}},{8{16'he11e}},{8{16'hd11d}},{8{16'hc11c}},{8{16'hb11b}},{8{16'ha11a}},{8{16'h9119}},{8{16'h8118}}};
        s_axis_tlast = 1;
        #10000;
        wr_addr_en = 0;
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
    
        for(i = 0; i < 59; i = i + 1) begin                 
            #160000;
            s_axis_tvalid = 1;
            s_axis_tdata = s_axis_tdata + 1;
            s_axis_tlast = 1;
            #10000;
            s_axis_tvalid = 0;
            s_axis_tlast = 0;
        end

        #200000;
        rd_addr_en = 1;
        start_rd_addr = 29'd128;   
        read_burst_len = 10'd480;
        #10000;
        rd_addr_en = 0;

        // for(i = 0; i < 59; i = i + 1) begin 
        //     #160000;
        //     #10000;
        // end 
        // $stop;   
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
    .start_wr_addr     (start_wr_addr),
    .start_rd_addr     (start_wr_addr),
    .write_done        (write_done),
    .write_burst_len   (write_burst_len),
    .read_done         (read_done),
    .read_burst_len    (read_burst_len),
    .wr_addr_en        (wr_addr_en),
    .rd_addr_en        (rd_addr_en),
    .clk_50M           (clk_50M),
    .s_axis_tvalid     (s_axis_tvalid),
    .s_axis_tlast      (s_axis_tlast),
    .s_axis_tdata      (s_axis_tdata),

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



