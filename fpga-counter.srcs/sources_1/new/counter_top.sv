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
    input   logic   speed_up,   // speed_up btn
    input   logic   speed_down, // speed_down btn
    output  logic [6:0] seg,    // 7-seg
    output  logic [7:0] an,      // display enable, 8 displays
    output  logic   db_speed_up,
    output  logic   db_speed_down
);


    logic   db_up_prev;
    logic   db_down_prev;

    logic   clk_slow;
    logic   clk_segment;
    logic   [31:0] count;
    logic   [2:0] select;
    logic   [3:0] bcde_in;
    logic   [7:0] an_enable;
    
    logic   increment_speed = 0;
    logic   dynamic_speed = 50_000_000;
    
    
    debouncer db_up (
        .clk(clk),
        .signal(speed_up),
        .reset(reset),
        .debounced_signal(db_speed_up)
    );
    
    debouncer db_down (
        .clk(clk),
        .signal(speed_down),
        .reset(reset),
        .debounced_signal(db_speed_down)
    );
    
    clock_divider #(.LIMIT(50_000_000), .N(27)) cd (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_slow),
        .dynamic_limit(dynamic_speed)
    );
    
    clock_divider #(.LIMIT(100_000), .N(17)) cd_segment (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_segment),
        .dynamic_limit(100_000)
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
    
    always_ff @(posedge clk) begin
        if (reset) begin
            dynamic_speed <= 50_000_000;
            db_up_prev <= 0;
            db_down_prev <= 0;
        end
        else begin
            if (db_speed_up && !db_up_prev) begin
                if (dynamic_speed > 5_000_000)
                    dynamic_speed <= dynamic_speed - 5_000_000;
            end
            if (db_speed_down && !db_down_prev) begin
                if (dynamic_speed < 100_000_000)
                    dynamic_speed <= dynamic_speed + 5_000_000;
            end
            db_up_prev <= db_speed_up;
            db_down_prev <= db_speed_down;
        end
    end
endmodule
