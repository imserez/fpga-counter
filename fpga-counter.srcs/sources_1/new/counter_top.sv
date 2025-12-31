`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2025 11:24:24
// Design Name: 
// Module Name: counter_top
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


module counter_top(
    input   logic clk,      // 100MHz nexys a7
    input   logic reset,    // rst button
    input   logic enable,   // enable button
    output  logic [6:0] seg,    // 7-seg
    output  logic [7:0] an      // display enable, 8 displays
);

    logic   clk_slow;
    logic   [15:0] count;
    
    clock_divider cd (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_slow)
    );
    
    counter cnt (
        .clk(clk_slow),
        .reset(reset),
        .enable(enable),
        .count(count)
    );
    
    seven_seg_decoder decoder (
        .bcde(count[3:0]),
        .segments(seg)
    );
    assign an = 8'b11111110;    // toggle just an0
endmodule
