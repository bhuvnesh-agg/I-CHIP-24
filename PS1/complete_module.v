`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2024 20:40:44
// Design Name: 
// Module Name: complete_module
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


module complete_module(
    input [31:0] in_a,
//    input [32:0] in_a2,
    input [31:0] in_b,
//    input [32:0] in_b2,
    output  [31:0] out_a,
    output  [31:0] out_b,
    output  [31:0] out_c
    );
    reg [31:0] int_c;
    wire fg;
    wire gg;
    float_multiplier_32bit M1 (
        in_a,
        in_b,
        gg
    );
    Floating_point_adder A1(
        gg,
        int_c,
        fg
    );
    initial
    begin
        int_c=31'd10;
    end
    assign out_a=in_a;
    assign out_b=in_b;
    always @(fg)
    begin
        int_c<=fg;
    end
    assign out_c=int_c;
    
        
    
    
endmodule
