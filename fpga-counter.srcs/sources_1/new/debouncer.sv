`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 13:21:44
// Design Name: 
// Module Name: debouncer
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


module debouncer #(
    parameter LIMIT = 1_000_000,
    parameter N = 20
    )(
    input   logic clk,
    input   logic signal,
    output  logic debounced_signal
    );
    
    logic   [N-1:0] count;
    logic   reset_counter = 1;
    logic   enable_counter = 0;
    
    counter #(.N(N)) counter (
        .clk(clk),
        .reset(reset_counter),
        .enable(enable_counter),
        .count(count)
    );
    
    always_ff @(posedge clk) begin
        if (signal != debounced_signal) begin
            enable_counter <= 1;
            reset_counter <= 0;
            if (count >= LIMIT)
                debounced_signal <= signal;;
        end
        else begin
            reset_counter <= 1;
            enable_counter <= 0;
        end
     end   
endmodule
