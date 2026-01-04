`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2025 11:11:55
// Design Name: 
// Module Name: seven_seg_decoder_tb
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


module seven_seg_decoder_tb;

    logic   [3:0] bcde;
    logic   [6:0] segments;
    logic   negative;
    
    seven_seg_decoder dut (
        .bcde(bcde),
        .segments(segments),
        .negative(negative)
    );
    
    initial negative = 0;
    
    initial begin
        for (int i = 0; i < 16; i++) begin
        
            bcde = i;
            #10;
            $display("BCD=%d -> segments=%b", bcde, segments);
        end
        
        $display("All digits tested");
        $finish;
    
    end
    
endmodule
