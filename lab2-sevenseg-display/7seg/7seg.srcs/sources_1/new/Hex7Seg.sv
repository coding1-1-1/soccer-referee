`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/11 11:33:41
// Design Name: 
// Module Name: Hex7Seg
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


module Hex7Seg( input  logic [3:0] digit,
                output logic [6:0] a2g );
    always_comb
      case(digit)            // gfedcba
        4'h0: a2g = 7'b1000000;
        4'h1: a2g = 7'b1111001;
        4'h2: a2g = 7'b0100100;
        4'h3: a2g = 7'b0110000;
        4'h4: a2g = 7'b0011001;
        4'h5: a2g = 7'b0010010;
        4'h6: a2g = 7'b0000010;
        4'h7: a2g = 7'b1111000;
        4'h8: a2g = 7'b0000000;
        4'h9: a2g = 7'b0010000;
        4'hA: a2g = 7'b0001000;
        4'hB: a2g = 7'b0000011;
        4'hC: a2g = 7'b1000110;
        4'hD: a2g = 7'b0100001;
        4'hE: a2g = 7'b0000110;
        4'hF: a2g = 7'b0001110;
      endcase
endmodule