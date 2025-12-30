`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2025 10:46:01
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input   logic clk,    // 100 MHz for Nexys A7
    input   logic reset,
    output  logic clk_out    // ~1 Hz (1s)
);
    logic   [26:0] counter;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end
        else if (counter == 50_000_000) begin // 50 Mhz. Using 5 for visual testing, 50_000_000 for 0,5seg
            counter <= 0;
            clk_out <= ~clk_out;        // every second
        end
        else begin
            counter <= counter + 1;
        end
     end
    
endmodule
