`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/23 16:17:57
// Design Name: 
// Module Name: ram2
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


module ram2(
input USER_CLK
    );
reg FPGA_Enable=0;
reg [9 : 0] FPGA_Write_Enable=10'h0;
reg [15 : 0] FPGA_Address=0;
reg [15 : 0] FPGA_Write_Data = 0;
reg [15 : 0] FPGA_Read_Data_reg = 0;
wire [15 : 0] FPGA_Read_Data;

reg [10 : 0] count = 0;
always@(posedge USER_CLK)
begin
	count <= count + 1;
	if(count <= 100)
	begin
		FPGA_Enable <= 0;
		FPGA_Write_Enable <= 10'h0;
	end
	else if((count <= 105)&&(count > 100))
	begin
		FPGA_Enable <= 1;
		FPGA_Write_Enable <= 10'hf;
		FPGA_Address <= FPGA_Address + 4;
		FPGA_Write_Data <= FPGA_Write_Data + 1;
	end
	else if((count <= 110)&&(count > 105))
	begin
		FPGA_Enable <= 0;
		FPGA_Write_Enable <= 10'h0;
		FPGA_Address <= 0;
		FPGA_Write_Data <= 0;
	end
	else if((count <= 117)&&(count > 110))
	begin
		FPGA_Enable <= 1;
		FPGA_Write_Enable <= 10'h0;
		FPGA_Read_Data_reg <= FPGA_Read_Data;
		FPGA_Address <= FPGA_Address + 4;
	end
	else if(count == 118)
	begin
		FPGA_Enable <= 0;
		count <= count;
	end
end

blk_mem_gen_1 tr_dram (
  .clka(USER_CLK), // input clka
  .ena(FPGA_Enable), // input ena
  .wea(FPGA_Write_Enable), // input [9 : 0] wea
  .addra(FPGA_Address), // input [15 : 0] addra
  .dina(FPGA_Write_Data), // input [15 : 0] dina
  .douta(FPGA_Read_Data), // output [15 : 0] douta

  .clkb(clkb), // input clkb
  .enb(enb), // input enb
  .web(web), // input [9 : 0] web
  .addrb(addrb), // input [15 : 0] addrb
  .dinb(dinb), // input [15 : 0] dinb
  .doutb(doutb) // output [15 : 0] doutb
);

endmodule
