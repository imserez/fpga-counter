`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.12.2025 15:34:50
// Design Name: 
// Module Name: seven_seg_selector
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


module seven_seg_selector(
    input logic clk,
    input logic reset,
    output logic [2:0] select,
    output  logic [7:0] an
    );
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            select <= '0;
        else
            select <= select + 1;
    end
    
    assign an = ~(1 << select);

endmodule
