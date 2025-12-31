`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.12.2025 10:10:58
// Design Name: 
// Module Name: counter
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


module counter #(
    parameter N = 16 // count up to 16 by default
 )(
    input  logic clk,
    input  logic reset,
    input  logic enable,
    output logic [(N - 1):0] count
);
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            count <= '0;
        else if (enable)
            count <= count + 1;
    end
    
endmodule
