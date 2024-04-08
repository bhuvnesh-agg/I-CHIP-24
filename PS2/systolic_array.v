`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 20:28:10
// Design Name: 
// Module Name: systolic_array
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
////////////////////////////////////////////////////////////////////////////////`//
`include "complete_module.v" 

module systolic_array(inp_west0, inp_west3, inp_west6,inp_north0, inp_north1, inp_north2,clk, rst, done);
input [31:0] inp_west0, inp_west3, inp_west6,
		      inp_north0, inp_north1, inp_north2;
	output reg done;
	input clk, rst;
	reg [3:0] count;
	wire [31:0] inp_north0, inp_north1, inp_north2;
	wire [31:0] inp_west0, inp_west3, inp_west6;
	wire [31:0] outp_south0, outp_south1, outp_south2, outp_south3, outp_south4, outp_south5, outp_south6, outp_south7, outp_south8, outp_south9, outp_south10, outp_south11, outp_south12, outp_south13, outp_south14, outp_south15;
	wire [31:0] outp_east0, outp_east1, outp_east2, outp_east3, outp_east4, outp_east5, outp_east6, outp_east7, outp_east8, outp_east9, outp_east10, outp_east11, outp_east12, outp_east13, outp_east14, outp_east15;
	wire [63:0] result0, result1, result2, result3, result4, result5, result6, result7, result8;

    complete_module P0 (inp_north0, inp_west0, outp_south0, outp_east0, result0);
	//from north
	complete_module P1 (inp_north1, outp_east0, outp_south1, outp_east1, result1);
	complete_module P2 (inp_north2, outp_east1, outp_south2, outp_east2, result2);
	
	//from west
	complete_module P3 (outp_south0, inp_west3, outp_south3, outp_east3, result3);
	complete_module P6 (outp_south3, inp_west6, outp_south6, outp_east6, result6);
	
	//no direct inputs
	//second row
	complete_module P5 (outp_south2, outp_east4,outp_south5, outp_east5, result5);
	complete_module P4 (outp_south1, outp_east3,  outp_south4, outp_east4, result4);
	//third row
	complete_module P7 (outp_south4, outp_east6, outp_south7, outp_east7, result7);
    complete_module P8 (outp_south5, outp_east7, outp_south8, outp_east8, result8);


always @(posedge clk or posedge rst) begin
		if(rst) begin
			done <= 0;
			count <= 0;
		end
		else begin
			if(count == 9) begin
				done <= 1;
				count <= 0;
			end
			else begin
				done <= 0;
				count <= count + 1;
			end
		end	
	end 
	
endmodule
