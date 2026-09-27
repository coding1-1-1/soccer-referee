`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/11 11:31:33
// Design Name: 
// Module Name: x7seg_Top
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


module x7seg_Top(
    input  logic        CLK100MHZ,
    input  logic [0:0]  SW,
    output logic        CA, CB, CC, CD, CE, CF, CG,   // 段选，与官方xdc端口名一致
    output logic [3:0]  AN,
    output logic        DP );

    logic [15:0] x;
    logic [6:0]  a2g;               // 内部段码总线，a2g[0]=a … a2g[6]=g
    assign x = 16'h2026;            // 实验要求：固定显示 2026

    // 总线 → 官方xdc端口名（CA=段a … CG=段g）
    assign {CG, CF, CE, CD, CC, CB, CA} = a2g;

    x7seg X7(.data(x),
             .clk (CLK100MHZ),
             .clr (SW[0]),
             .a2g (a2g),
             .an  (AN),
             .dp  (DP)  );
endmodule