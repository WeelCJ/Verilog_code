`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 17:59:51
// Design Name: 
// Module Name: data_readfddr4
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
//  Additional Comments:
// AXI Interface Read Data From DDR
// Main Function : input a address，read data from ddr constantly
//////////////////////////////////////////////////////////////////////////////////

module data_readfddr4 #(
    parameter maxiaw = 29,          //axi写地址36位
    parameter maxidw = 128,          //axi写数据128位
    parameter maxisw = maxidw/8     //axi写数据的大小（字节数）
)
(
    input m_axi_mm2s_aclk,              //AXI Stream Read 主接口类型
    input m_axi_mm2s_aresetn,

    //读地址通道
    output reg [3:0] m_axi_mm2s_arid,
    output [maxiaw-1:0] m_axi_mm2s_araddr,
    output reg [7:0] m_axi_mm2s_arlen,
    output reg [2:0] m_axi_mm2s_arsize,
    output reg [1:0] m_axi_mm2s_arburst,
    output reg [3:0] m_axi_mm2s_arcache,
    output reg m_axi_mm2s_arvalid,
    input m_axi_mm2s_arready,

    //读数据（包含了读响应）通道
    input [3 : 0] m_axi_mm2s_rid,
    input [maxidw-1:0] m_axi_mm2s_rdata,
    input [1:0] m_axi_mm2s_rresp,
    input m_axi_mm2s_rlast,
    input m_axi_mm2s_rvalid,
    output m_axi_mm2s_rready,

    input [28:0] start_rd_addr,                   //开始读数据的地址
    input rd_addr_en,                             //开始使能信号

    output reg read_done,                         //读完成

    input  m_axis_aclk,
    output [15:0] m_axis_tdata,          //stream协议读出
    output m_axis_tvalid,
    output m_axis_tlast,
    input  m_axis_tready,

    input [9 : 0] read_burst_len

);
    
 // function called clogb2 that returns an integer which has the                      
 // value of the ceiling of the log base 2.                                           
function integer clogb2 (input integer bit_depth);                                   
  begin                                                                              
    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                                      
        bit_depth = bit_depth >> 1;                                                    
  end                                                                                
endfunction                 
 
localparam  maxikw = clogb2(maxisw-1);

/* Parameter definitions of STATE variables*/
localparam [2:0]  S0 = 3'd0, //S0=0
                  S1 = 3'd1, //S1=1
                  S2 = 3'd2, //S2=2
                  S3 = 3'd3, //S3=3
                  S4 = 3'd4, //S4=4
                  S5 = 3'd5, //S4=5
                  S6 = 3'd6; //S4=6

wire [15:0] fifo_out;
wire prog_full;                              //在外界快要达到FIFO读出数据的临界时，继续从DDR读数
wire fifo_empty, almost_empty;
reg [127:0] fifo_in;
reg fifo_write;

assign  m_axis_tvalid = ~fifo_empty;         //直到fifo读空为止
assign  m_axis_tlast = fifo_empty;
assign  m_axis_tdata = fifo_out;
          
                      
reg [2:0] state;        

assign m_axi_mm2s_rready = 1'b1;

wire [28 : 0] read_addr_ad;      
reg [28 : 0] start_rd_addr_reg;
assign m_axi_mm2s_araddr = start_rd_addr_reg;

assign read_addr_ad = (rd_addr_en) ? 0 : 29'd128;     //地址的累加(也可以直接用数加)

reg [9 : 0] read_cnt;                                 //读计数器

always @( posedge m_axi_mm2s_aclk or negedge m_axi_mm2s_aresetn )begin
  if (~m_axi_mm2s_aresetn) begin
    state <= S0;
    fifo_write <= 0;
    fifo_in <= 0;
    start_rd_addr_reg <= 0;
    m_axi_mm2s_arvalid <= 0;
    m_axi_mm2s_arid <= 0;
    read_cnt <= 0;
  end else begin
    m_axi_mm2s_arcache <= 4'd0;
    m_axi_mm2s_arvalid <= 0;
    m_axi_mm2s_arlen <= 8'd7;
    m_axi_mm2s_arsize <= maxikw;
    m_axi_mm2s_arburst <= 2'b01;   
      
    case(state)
        S0: begin
            if(rd_addr_en) begin
                state <= S1;
                read_cnt <= 0;
                start_rd_addr_reg <= start_rd_addr;
            end else begin
                state <= state;
            end
        end
        S1: begin
            if (~prog_full) begin
                state <= S2;
                start_rd_addr_reg <= start_rd_addr_reg + read_addr_ad;
            end else begin
                state <= state;
            end
        end
        S2: begin
            if(m_axi_mm2s_arvalid && m_axi_mm2s_arready) begin
                state <= S3;
                m_axi_mm2s_arid <= m_axi_mm2s_arid + 1;
                m_axi_mm2s_arvalid <= 0;
            end else begin
                m_axi_mm2s_arvalid <= 1;
            end
        end
        S3: begin
            if(m_axi_mm2s_rvalid && m_axi_mm2s_rready) begin
                if (m_axi_mm2s_rlast) begin
                    state <= S4; 
                    fifo_in <= m_axi_mm2s_rdata;
                    read_cnt <= read_cnt + 8;
                end else begin
                    fifo_in <= m_axi_mm2s_rdata;
                end
                fifo_write <= 1;
            end else begin
                fifo_write <= 0;
            end
        end
        S4: begin
            fifo_write <= 0;                     //可以给fifo_write添加一个约束条件，不能无止尽的写
            if (read_cnt == read_burst_len) begin
                state <= S5;
                fifo_write <= 0;
            end else begin
                state <= S1;
            end
        end
        S5: begin
            if (fifo_empty) begin                 //产生读完成脉冲信号
                state <= S6;
            end else begin
                state <= state;
            end
        end
        S6: begin
            read_cnt <= 0;
            state <= S0;
        end
        default: state <= S0; 
    endcase
  end
end

always @(posedge m_axis_aclk or negedge m_axi_mm2s_aresetn) begin
    if(~m_axi_mm2s_aresetn) begin
        read_done <= 0;
    end else begin
        if (almost_empty & (read_cnt == read_burst_len)) begin
            read_done <= 1;
        end else begin
            read_done <= 0;
        end
    end
end

fifo_generator_1 uut1 (
  .rst(~m_axi_mm2s_aresetn),                   // input wire rst
  .wr_clk(m_axi_mm2s_aclk),                    // input wire wr_clk
  .rd_clk(m_axis_aclk),                        // input wire rd_clk
  .din(fifo_in),                               // input wire [127 : 0] din
  .wr_en(fifo_write),                          // input wire wr_en
  .rd_en(m_axis_tvalid & m_axis_tready),       // input wire rd_en
  .dout(fifo_out),                             // output wire [127 : 0] dout
  .full(),                                     // output wire full
  .prog_full(prog_full),                       // output wire prog_full
  .almost_empty(almost_empty),                 // output wire almost_empty
  .empty(fifo_empty)                           // output wire empty
);
     
endmodule
