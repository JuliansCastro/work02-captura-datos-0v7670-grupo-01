`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:31 11/12/2019 
// Design Name: 
// Module Name:    Captura 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Captura(
    input [7:0] Data,
    input Href,
    input Vsync,
    input Pclk,
    output regWrite,
    output reg [16:0]addr_in,
	 output reg [7:0]data_in
    );
	 reg contador=0;
	 reg w=0;
	 reg [16:0]addr=0;
always @ (negedge Pclk) begin
	if	(Vsync==0) begin
		if	(Href==1) begin
		w=0;
			if	(contador==0)begin
				data_in[7]=Data[7];
				data_in[6]=Data[6];
				data_in[5]=Data[5];
				data_in[4]=Data[2];
				data_in[3]=Data[1];
				data_in[2]=Data[0];
				contador=1;
			end
			if	(contador==1)begin
				data_in[1]=Data[4];
				data_in[0]=Data[3];
				contador=0;
				w=1;
				addr_in<=addr;
				addr=addr+1;
			end
		end
	end
end
assign regWrite=w;

endmodule
