`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/25 22:56:19
// Design Name: 
// Module Name: Ram4
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


module ram4(
input clk
    );
reg ena = 1;
reg wea = 1;
reg enb,web;
reg [3:0] addra = 4'b0;
reg [3:0] addrb = 4'b0;
reg [15:0] dina = 16'hff00;
reg [15:0] dinb;
wire [15:0] douta,doutb;
reg [10:0] count = 11'b0;

always@(posedge clk)
begin
	if(count >= 11'd200 && count <= 11'd210)
	begin
		enb <= 1;
		addrb <= addrb + 4'b1;
		count <= count + 1;
	end
	else if(count >= 11'd100 && count <= 11'd110)
	begin
		dina <= dina + 16'h1;
		addra <= addra + 4'b1;
		count <= count + 1;
	end
	else
	begin
		count <= count + 1;
	end
end

blk_mem_gen_2 ram4_te (
  .clka(clk),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [3 : 0] addra
  .dina(dina),    // input wire [15 : 0] dina
  .douta(douta),  // output wire [15 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(enb),      // input wire enb
  .web(web),      // input wire [0 : 0] web
  .addrb(addrb),  // input wire [3 : 0] addrb
  .dinb(dinb),    // input wire [15 : 0] dinb
  .doutb(doutb)  // output wire [15 : 0] doutb
);

endmodule
