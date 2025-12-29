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


`timescale 1ns / 1ps

module counter (
    input  logic clk,
    input  logic reset,
    output logic [7:0] count
);
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            count <= 8'b0;
        else
            count <= count + 1;
    end
    
endmodule
