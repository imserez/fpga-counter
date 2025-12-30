`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2025 11:08:20
// Design Name: 
// Module Name: seven_seg_decoder
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


module seven_seg_decoder(
    input   logic [3:0] bcd,        // 0-9 nums
    output  logic [6:0] segments   // a:g
    );
      
     // segments = {g, f, e, d, c, b, a}
     // 0 is on, 1 is off
     // combinational circuit, no memory, no clock. Output depends only on input bcd
     always_comb begin
        case (bcd)
            4'h0: segments = 7'b1000000; // 0
            4'h1: segments = 7'b1111001; // 1
            4'h2: segments = 7'b0100100; // 2
            4'h3: segments = 7'b0110000; // 3
            4'h4: segments = 7'b0011001; // 4
            4'h5: segments = 7'b0010010; // 5
            4'h6: segments = 7'b0000010; // 6
            4'h7: segments = 7'b1111000; // 7
            4'h8: segments = 7'b0000000; // 8
            4'h9: segments = 7'b0010000; // 9
            default: segments = 7'b1111111; // apagado
        endcase
    end
    
endmodule