`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/07 18:42:38
// Design Name: 
// Module Name: ball
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


module ball(
    input logic [15:0]SW,
    output logic [15:0]LED
    );
    assign LED[0]=SW[0];
    assign LED[15]=SW[15];
    assign LED[8]=SW[15]&SW[0];
endmodule
