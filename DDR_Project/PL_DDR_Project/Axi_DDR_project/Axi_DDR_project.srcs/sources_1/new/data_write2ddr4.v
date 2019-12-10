`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 17:59:07
// Design Name: 
// Module Name: data_write2ddr4
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
// AXI Interface Write Data to DDR
// Main Function : input a address，write data to ddr constantly
//////////////////////////////////////////////////////////////////////////////////

module data_write2ddr4 #(
    parameter maxiaw = 29,          //axi写地址36位
    parameter maxidw = 128,          //axi写数据128位
    parameter maxisw = maxidw/8     //axi写数据的大小（字节数）
)
(
    input m_axi_s2mm_aclk,      //总线时钟       AXI Stream Write主接口类型
    input m_axi_s2mm_aresetn,   //复位
    
    //AXI总线 写入DDR的参数，可以根据官方例程来配置
    output reg [3:0] m_axi_s2mm_awid,
    output reg [maxiaw-1:0] m_axi_s2mm_awaddr,
    output reg [7:0] m_axi_s2mm_awlen,
    output reg [2:0] m_axi_s2mm_awsize,
    output reg [1:0] m_axi_s2mm_awburst,
    output reg [2:0] m_axi_s2mm_awprot,
    output reg [3:0] m_axi_s2mm_awcache,
    output reg m_axi_s2mm_awvalid,
    input m_axi_s2mm_awready,
    
    //写数据通道
    output [maxidw-1:0] m_axi_s2mm_wdata,
    output reg [maxisw-1:0] m_axi_s2mm_wstrb,
    output m_axi_s2mm_wlast,
    output m_axi_s2mm_wvalid,
    input m_axi_s2mm_wready,
    
    //写响应通道
    input [3 : 0] m_axi_s2mm_bid,
    input [1 : 0] m_axi_s2mm_bresp,
    input m_axi_s2mm_bvalid,
    output reg m_axi_s2mm_bready,
    
    //与control模块相连
    input [28:0] start_wr_addr,                   //开始写数据的地址
    input wr_addr_en,                             //开始使能信号
    
//    output reg write_idle,             //空闲
//    output reg write_done,             //完成信号
    
    input s_axis_aclk,              //用户模块的输入时钟
    
    //与cal_ip模块相连
    input [1023:0] s_axis_tdata,
    input s_axis_tvalid,
    input s_axis_tlast,
    output s_axis_tready
    
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
localparam [4:0]  S0 = 5'd0, //S0=0
                  S1 = 5'd1, //S1=1
                  S2 = 5'd2, //S2=2
                  S3 = 5'd3, //S3=3
                  S4 = 5'd4, //S4=3
                  S5 = 5'd5; //S5=3

reg [4:0] state_in, state_out;               //数据输入异步FIFO的state_in和从异步FIFO输入DDR的state_out


reg axi_s2mm_wvalid;                         //寄存写数据信号
reg axi_s2mm_wlast;                          //寄存数据结束信号

reg [1023 : 0] axis_tdata;                   //数据寄存，五个周期读一次   
wire [255 : 0] data_reg [0 : 3];

wire [28 : 0] write_addr_ad;           //写地址加
reg [28 : 0] start_wr_addr_reg;        //开始地址的寄存，方便之后使用     

reg [255 : 0] fifo_in;
reg fifo_write;

reg [3:0] sendlen;                     //一次发送8个数据进DDR

assign s_axis_tready = s_axis_tvalid && (sendlen == 1);     //写完后初始化成功后开始传输

assign {data_reg[3], data_reg[2], data_reg[1], data_reg[0]} = axis_tdata;
assign write_addr_ad = (wr_addr_en) ? 0 : 29'd128;          //地址的累加(也可以直接用数加)

wire fifo_full;             
wire fifo_empty;            
wire [127 : 0] fifo_out; 

assign m_axi_s2mm_wvalid = (axi_s2mm_wvalid & ~fifo_empty) ;//写有效且FIFO为空或者继续写有效
assign m_axi_s2mm_wlast = (axi_s2mm_wlast & ~fifo_empty);


reg [3:0] fifo_count;             //传输四个256位的数据

always @(posedge s_axis_aclk or negedge m_axi_s2mm_aresetn) begin
    if(~m_axi_s2mm_aresetn) begin
        fifo_count <= 0;                //等待计时    
        fifo_write <= 0;
        axis_tdata <= 0;
        start_wr_addr_reg <= 0;
        state_in <= S0;
    end else begin
        case (state_in)
            S0: begin
                if (s_axis_tvalid && s_axis_tready && wr_addr_en) begin
                    axis_tdata <= s_axis_tdata;
                    start_wr_addr_reg <= start_wr_addr;
                    state_in <= S1;
                end else begin 
                    if (s_axis_tvalid && s_axis_tready && (sendlen == 1)) begin   //表示已经写完一次
                        axis_tdata <= s_axis_tdata;
                        start_wr_addr_reg <= start_wr_addr_reg + write_addr_ad;
                        state_in <= S1;
                    end else begin
                        state_in <= state_in;
                    end
                end
            end
            S1: begin
                if(fifo_count == 4'd4) begin
                    fifo_count <= 0;
                    fifo_write <= 0;
                    state_in <= S2;
                end else begin
                    fifo_write <= 1;
                    fifo_count <= fifo_count + 4'd1;
                    fifo_in <= data_reg[fifo_count];
                end
            end
            S2: begin
                state_in <= S0;
            end
            default : state_in <= S0;
        endcase
    end
end

always @( posedge m_axi_s2mm_aclk or negedge m_axi_s2mm_aresetn ) begin
    if(~m_axi_s2mm_aresetn) begin    //同步复位
        state_out <= S3;
//        write_idle <= 1;
//        write_done <= 0;
        sendlen <= 0;                //突发传输的发送次数
        axi_s2mm_wlast <=  0;          //最后一次突发传输  
        axi_s2mm_wvalid <=  0;            //写无效    
        m_axi_s2mm_awvalid <= 0;      //表明此通道的地址控制信号有效 
        m_axi_s2mm_awaddr <= 0; 
        m_axi_s2mm_awid <= 0;        
      end else begin
        m_axi_s2mm_awprot <= 0;            //默认
        m_axi_s2mm_awcache <= 4'd0;        //正常非缓存的Buffer存储
        m_axi_s2mm_awvalid <= 0;           //表明此通道的地址控制信号有效
        m_axi_s2mm_awlen <= 8'd7;          //突发传输的次数
        m_axi_s2mm_awsize <= maxikw;          //一次传几个字节
        m_axi_s2mm_awburst <= 2'b01;      //AXI3所有突发长度为1-16；AXI4 INCR为1-256，其他为1-16
        m_axi_s2mm_wstrb <= {maxisw{1'b1}};   //用来表明哪8bit是有效的
        m_axi_s2mm_bready <= 1;           //表示主机能够接收写响应
//        write_done <= 0;

        case (state_out)
            S3: begin
                sendlen <= 1;
                if (~fifo_empty) begin                           
                    if (m_axi_s2mm_awvalid && m_axi_s2mm_awready) begin
                        state_out <= S4;
                        m_axi_s2mm_awvalid <= 0;
                        m_axi_s2mm_awid <= m_axi_s2mm_awid + 1;
                    end else begin
                        m_axi_s2mm_awvalid <= 1;
                        m_axi_s2mm_awaddr <= start_wr_addr_reg;
                    end
                end else begin
                    m_axi_s2mm_awvalid <= 0;
                end
            end
            S4: begin
                if (m_axi_s2mm_wvalid && m_axi_s2mm_wready && m_axi_s2mm_wlast) begin
                    state_out <= S5;
                    axi_s2mm_wlast <= 0;
                    axi_s2mm_wvalid <= 0;
//                    ap_done <= 1;
                end else begin
                    if (m_axi_s2mm_wvalid && m_axi_s2mm_wready) begin
                        if (sendlen >= 7) begin
                            axi_s2mm_wlast <=  1;
                        end else begin
                            sendlen <= sendlen + 1; 
                        end 
                    end else begin
                        axi_s2mm_wvalid <=  1;
                    end
                end
            end
            S5: begin
                state_out <= S3;                   //延迟（可以去除）
            end
            default : state_out <= S3;
        endcase
    end
end   

fifo_generator_0 uut1 (
  .rst(~m_axi_s2mm_aresetn),        // input wire rst
  .wr_clk(s_axis_aclk),         // input wire wr_clk
  .rd_clk(m_axi_s2mm_aclk),  // input wire rd_clk
  .din(fifo_in),        // input wire [255 : 0] din
  .wr_en(fifo_write),    // input wire wr_en
  .rd_en(m_axi_s2mm_wready & axi_s2mm_wvalid & ~fifo_empty),    // input wire rd_en
  .dout(fifo_out),      // output wire [127 : 0] dout
  .full(fifo_full),      // output wire full
  .empty(fifo_empty)    // output wire empty
);

assign m_axi_s2mm_wdata = axi_s2mm_wvalid ? fifo_out : 0;

endmodule
  