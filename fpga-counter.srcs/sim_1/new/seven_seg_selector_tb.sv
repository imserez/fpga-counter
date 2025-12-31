`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.12.2025 16:19:11
// Design Name: 
// Module Name: seven_seg_selector_tb
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


module seven_seg_selector_tb;
    logic clk;
    logic reset;
    logic [2:0] select;
    logic [7:0] an;
        
    seven_seg_selector dut(
        .clk(clk),
        .reset(reset),
        .select(select),
        .an(an)
    );
    
   
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin 
        reset = 1;
        #50;
        reset = 0;
        
        #500;
        $finish;
    end
endmodule
