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
    logic   clk_segment;
    logic   [31:0] count;
    logic   [2:0] select;
    logic   [3:0] bcde_in;
    logic   [7:0] an_enable;
    
    clock_divider #(.LIMIT(50_000_000), .N(27)) cd (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_slow)
    );
    
    clock_divider #(.LIMIT(100_000), .N(17)) cd_segment (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_segment)
    );
    
    seven_seg_selector segment_select (
        .clk(clk_segment),
        .reset(reset),
        .select(select),
        .an(an_enable)
    );
    
    counter #(.N(32)) cnt (
        .clk(clk_slow),
        .reset(reset),
        .enable(enable),
        .count(count)
    );
    
    seven_seg_decoder decoder (
        .bcde(bcde_in),
        .segments(seg)
    );
    assign an = an_enable;
    
    always_comb begin
        case(select)
            3'b000: begin
                bcde_in = count[3:0];
            end
            3'b001: begin
                bcde_in = count[7:4];
            end
            3'b010: begin
                bcde_in = count[11:8];
            end
            3'b011: begin
                bcde_in = count[15:12];
            end
            3'b100: begin
                bcde_in = count[19:16];
            end
            3'b101: begin
                bcde_in = count[23:20];
            end
            3'b110: begin
                bcde_in = count[27:24];
            end
            3'b111: begin
                bcde_in = count[31:28];
            end
        endcase
    end
endmodule
