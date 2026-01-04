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
    input   logic   count_up,
    input   logic   count_down,
    output  logic [6:0] seg,    // 7-seg
    output  logic [7:0] an,     // display enable, 8 displays
    output   logic   led_15 
);

    logic   db_speed_up;
    logic   db_speed_down;
    logic   db_up_prev;
    logic   db_down_prev;
    
    logic   negative;
    
    logic   db_count_up;
    logic   db_count_down;
    logic   db_count_up_prev;
    logic   db_count_down_prev;

    logic   mode = 1; // start counting upwards

    logic   clk_slow;
    logic   clk_segment;
    logic   [31:0] count;
    logic   [31:0] twos_comp_count;
    logic   [2:0] select;
    logic   [3:0] bcde_in;
    logic   [7:0] an_enable;
    
    logic   [31:0] dynamic_speed = 50_000_000;
    
    
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
    
    debouncer db_cd (
        .clk(clk),
        .signal(count_down),
        .reset(reset),
        .debounced_signal(db_count_down)
    );
    debouncer db_cup (
        .clk(clk),
        .signal(count_up),
        .reset(reset),
        .debounced_signal(db_count_up)
    );
    
    clock_divider #(.LIMIT(50_000_000), .N(32)) cd (
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
        .count(count),
        .mode(mode)
    );
    
    seven_seg_decoder decoder (
        .bcde(bcde_in),
        .segments(seg),
        .negative(negative && (select == 3'b111))
    );
    assign an = an_enable;
    assign led_15 = enable;
    
    always_comb begin
        if (count[31]) begin // negative number 2's complement
            twos_comp_count = -count;
            negative = 1;
        end
        else begin
            twos_comp_count = count;
            negative = 0;
        end
        case(select)
            3'b000: begin
                bcde_in = twos_comp_count[3:0];
            end
            3'b001: begin
                bcde_in = twos_comp_count[7:4];
            end
            3'b010: begin
                bcde_in = twos_comp_count[11:8];
            end
            3'b011: begin
                bcde_in = twos_comp_count[15:12];
            end
            3'b100: begin
                bcde_in = twos_comp_count[19:16];
            end
            3'b101: begin
                bcde_in = twos_comp_count[23:20];
            end
            3'b110: begin
                bcde_in = twos_comp_count[27:24];
            end
            3'b111: begin
                if (negative)
                    bcde_in = 4'hF;
                else
                    bcde_in = twos_comp_count[31:28];
            end
        endcase
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            dynamic_speed <= 50_000_000;
            db_up_prev <= 0;
            db_down_prev <= 0;
            db_count_up_prev <= 0;
            db_count_down_prev <= 0;
            mode <= 0;
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
            
            if (db_count_up && !db_count_up_prev) begin
               mode <= 1;
            end
            if (db_count_down && !db_count_down_prev) begin
                mode <= 0;
            end
            db_count_up_prev <= db_count_up;
            db_count_down_prev <= db_count_down;
            
            db_up_prev <= db_speed_up;
            db_down_prev <= db_speed_down;
           
        end
    end
endmodule
