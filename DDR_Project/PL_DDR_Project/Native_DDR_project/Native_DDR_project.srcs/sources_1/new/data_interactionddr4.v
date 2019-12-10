`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 11:40:25
// Design Name: 
// Module Name: data_interactionddr4
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


module data_interactionddr4 #(
  parameter SIMULATION       = "FALSE",   // This parameter must be
                                          // TRUE for simulations and 
                                          // FALSE for implementation.
                                          //
  parameter APP_DATA_WIDTH   = 32,        // Application side data bus width.
                                          // It is 8 times the DQ_WIDTH.
                                          //
  parameter APP_ADDR_WIDTH   = 32,        // Application side Address bus width.
                                          // It is sum of COL, ROW and BANK address
                                          // for DDR3. It is sum of COL, ROW, 
                                          // Bank Group and BANK address for DDR4.
                                          //
  parameter nCK_PER_CLK      = 4,         // Fabric to PHY ratio
                                          //
  parameter MEM_ADDR_ORDER   = "ROW_COLUMN_BANK" // Application address order.
                                                 // "ROW_COLUMN_BANK" is the default
                                                 // address order. Refer to product guide
                                                 // for other address order options.
  )
 (
    input ui_clk,
    input ddr_clk,
    input rst,
    input rd_addr_en,                             //读请求
    input wr_addr_en,                             //写请求
    input write_en,                               //外部的写开始信号，写进FIFO
    input[APP_ADDR_WIDTH - 1 : 0] start_wr_addr,  //读首地址
    input[APP_ADDR_WIDTH - 1 : 0] start_rd_addr,  //写首地址

    input[1023 : 0] wr_data,                      //写入的数据
    output[15 : 0] rd_data,                       //读出的数据

    input[9:0] rd_trans_len,                      //读数据长度
    input[9:0] wr_trans_len,                      //写数据长度

    output reg write_done,                        //写结束
    output reg read_done,                         //读结束
    output [2 : 0] app_cmd,
    output [APP_ADDR_WIDTH - 1 : 0] app_addr,
    output app_en,
    input app_rdy,

    input app_wdf_rdy,
    output [APP_DATA_WIDTH - 1 : 0] app_wdf_data,
    output app_wdf_wren,
    output app_wdf_end,

    input [APP_DATA_WIDTH - 1 : 0] app_rd_data,
    input app_rd_data_valid

//    input app_rd_data_end

//    input init_calib_complete
    );

localparam IDLE_UI =              4'd0,
           WRITE_FIFO =           4'd1,
           WRITE_FIFO_END =       4'd2,
           IDLE_DDR =             4'd3,
           WRITE_START  =         4'd4,
           WRITE_WAIT =           4'd5,
           WRITE_END =            4'd6,
           READ_START =           4'd7,
           READ_END =             4'd8,
           READ_DONE =            4'd9,
           READ_DONE_WAIT =       4'd10;

// Instruction encoding 
localparam WR_INSTR = 3'b000; // 读命令
localparam RD_INSTR = 3'b001; // 写命令

reg[3:0] state_ui, state_ddr;               //用户读写状态和DDR读写状态

reg[9:0] rd_addr_cnt;                       //读地址计数
reg[9:0] rd_data_cnt;                       //读数据计数
reg[9:0] wr_addr_cnt;                       //写地址计数
reg[9:0] wr_data_cnt;                       //写数据计数

reg[2:0] app_cmd_r;                         //命令寄存
reg [APP_ADDR_WIDTH-1:0] start_wr_addr_reg, start_rd_addr_reg;     //首地址的寄存，方便后面的累加
reg [APP_ADDR_WIDTH-1:0] app_addr_wr, app_addr_rd;                 //读写地址寄存
wire app_en_wr, app_en_rd;                           
//reg app_wdf_wren_r;
wire fifo_progfull;                                                //阈值的设置要小于总容量的一半，防止出现full的状态
wire fifo_wr_empty, fifo_rd_empty;   

assign app_cmd = app_cmd_r;                     
assign app_addr = (app_cmd_r == 3'b000) ? app_addr_wr : app_addr_rd;                   
assign app_en = app_en_wr | app_en_rd;
assign app_en_wr = (~fifo_wr_empty) & (app_rdy) & (state_ddr == WRITE_START);        //app_en信号要跟随app_rdy信号的变化
assign app_en_rd = (~fifo_progfull) & (app_rdy) & (state_ddr == READ_START);
                                                          
assign app_wdf_end = app_wdf_wren;
assign app_wdf_wren = app_rdy & app_wdf_rdy & (~fifo_wr_empty);                      //写数据有效信号app_wdy_wren也要随app_rdy的变化
          
reg [1023 : 0] wr_data_reg;                                                          //数据寄存，五个周期读一次   
wire [255 : 0] data_reg [0 : 3];

reg [255 : 0] fifo_in;
reg fifo_write;
reg [2:0] fifo_count;                                                                //传输四个256位的数据

assign {data_reg[3], data_reg[2], data_reg[1], data_reg[0]} = wr_data_reg;

always @(posedge ui_clk or negedge rst) begin                                        //主要功能是写数据进异步FIFO
    if(~rst) begin
        fifo_count <= 0;                //等待计时    
        fifo_write <= 0;
        wr_data_reg <= 0;
        state_ui <= IDLE_UI;
    end else begin
        case (state_ui)
            IDLE_UI: begin
                if (wr_addr_en || write_en) begin
                    wr_data_reg <= wr_data;
                    state_ui <= WRITE_FIFO;
                end else begin 
                    state_ui <= state_ui;
                end
            end
            WRITE_FIFO: begin
                if(fifo_count == 3'd4) begin
                    fifo_count <= 0;
                    fifo_write <= 0;
                    state_ui <= WRITE_FIFO_END;
                end else begin
                    fifo_write <= 1;
                    fifo_count <= fifo_count + 1;
                    fifo_in <= data_reg[fifo_count];
                end
            end
            WRITE_FIFO_END: begin
                state_ui <= IDLE_UI;
            end
            default : state_ui <= IDLE_UI;
        endcase
    end
end

always @(posedge ddr_clk or negedge rst) begin 
    if(~rst) begin
        state_ddr <= IDLE_DDR;
        app_cmd_r <= WR_INSTR;
        app_addr_wr <= 0;
        app_addr_rd <= 0;
        start_wr_addr_reg <= 0;
        start_rd_addr_reg <= 0;
        wr_addr_cnt <= 0;
        wr_data_cnt <= 0;
        rd_addr_cnt <= 0;
        rd_data_cnt <= 0;
        write_done <= 0;
        read_done <= 0;
    end else begin
        case (state_ddr)
            IDLE_DDR: begin
                if (wr_addr_en) begin                                         //写开始，给首地址
                    state_ddr <= WRITE_START;
                    app_cmd_r <= WR_INSTR;
                    wr_addr_cnt <= 0;
                    start_wr_addr_reg <= start_wr_addr;
                end
                else if (rd_addr_en) begin                                    //读开始，给首地址
                    state_ddr <= READ_START;
                    app_cmd_r <= RD_INSTR;
                    rd_data_cnt <= 0;
                    start_rd_addr_reg <= start_rd_addr;
                end else begin
                    state_ddr <= state_ddr;
                end
            end
            WRITE_START: begin
                if (app_rdy && ~fifo_wr_empty) begin
                     app_addr_wr <= start_wr_addr_reg;
                    if (wr_addr_cnt == wr_trans_len - 1) begin
                        write_done <= 1;
                        wr_addr_cnt <= 0;
                        state_ddr <= WRITE_END;
                    end else begin
                        wr_addr_cnt <= wr_addr_cnt + 1;
                    end
                    start_wr_addr_reg <= start_wr_addr_reg + 'b1000;
                end
                if (app_rdy && app_wdf_rdy && ~fifo_wr_empty) begin
                    if (wr_data_cnt == wr_trans_len - 1) begin
                        wr_data_cnt <= 0;
//                        state_ddr <= WRITE_END;                                 //由于读数据和地址计数器是同步的，所以这一步也没必要
                    end else begin
                        wr_data_cnt <= wr_data_cnt + 1;
                    end
                end
            end
            WRITE_END: begin
              write_done <= 0;                                             //产生写完成的脉冲
              state_ddr <= IDLE_DDR;
            end
            READ_START: begin
                if (app_rdy && ~fifo_progfull) begin                          //读地址一般会优先读数据结束
                    app_addr_rd <= start_rd_addr_reg;
                    if(rd_addr_cnt == rd_trans_len - 1) begin
                        rd_addr_cnt <= 0;
                        state_ddr <= READ_END;
                    end else begin
                        rd_addr_cnt <= rd_addr_cnt + 1;
                    end
                    start_rd_addr_reg <= start_rd_addr_reg + 'b1000;
                end
                // if (app_rd_data_valid) begin                             //读数据计数器，滞后读地址计数器
                //     if(rd_data_cnt == rd_trans_len - 1) begin
                //         rd_data_cnt <= 0;
                //         state_ddr <= READ_END;
                //     end else begin
                //         rd_data_cnt <= rd_data_cnt + 1;
                //     end
                // end
            end
            READ_END: begin
              state_ddr <= READ_DONE;
            end
            READ_DONE: begin
              if (fifo_rd_empty) begin                                   //若读空，那么读数据完成
                read_done <= 1;
                state_ddr <= READ_DONE_WAIT;
              end else begin
                state_ddr <= state_ddr;
              end
            end
            READ_DONE_WAIT: begin
              read_done <= 0;                                            //产生read_done脉冲信号
              state_ddr <= IDLE_DDR;
            end
         default : state_ddr <= IDLE_DDR;
        endcase
    end
end

fifo_generator_0 uut_write (                            //write FIFO       
  .rst(~rst),                                           // input wire rst
  .wr_clk(ui_clk),                                      // input wire wr_clk
  .rd_clk(ddr_clk),                                     // input wire rd_clk
  .din(fifo_in),                                        // input wire [255 : 0] din
  .wr_en(fifo_write),                                   // input wire wr_en
  .rd_en(app_rdy && app_wdf_rdy & ~fifo_wr_empty),      // input wire rd_en
  .dout(app_wdf_data),                                  // output wire [127 : 0] dout
  .full(),                                              // output wire full
  .empty(fifo_wr_empty)                                 // output wire empty
);

fifo_generator_1 uut_read (                             //read FIFO 
  .rst(~rst),                                           // input wire rst
  .wr_clk(ddr_clk),                                     // input wire wr_clk
  .rd_clk(ui_clk),                                      // input wire rd_clk
  .din(app_rd_data),                                    // input wire [127 : 0] din
  .wr_en(app_rd_data_valid),                            // input wire wr_en
  .rd_en(~fifo_rd_empty),                               // input wire rd_en
  .dout(rd_data),                                       // output wire [15 : 0] dout
  .full(),                                              // output wire full
  .prog_full(fifo_progfull),                            // output wire prog_full
  .empty(fifo_rd_empty)                                 // output wire empty
);

endmodule
