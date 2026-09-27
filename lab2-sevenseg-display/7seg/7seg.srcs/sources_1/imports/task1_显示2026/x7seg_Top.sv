`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: x7seg_Top
// Description: 实验2-任务1  右侧4个七段数码管显示固定数据 2026
//////////////////////////////////////////////////////////////////////////////////

module x7seg_Top(
    input  logic        CLK100MHZ,
    input  logic [0:0]  SW,
    output logic        CA, CB, CC, CD, CE, CF, CG,   
    output logic [3:0]  AN,
    output logic        DP );

    logic [15:0] x;
    logic [6:0]  a2g; 
    assign x = 16'h2026;           
    assign {CG, CF, CE, CD, CC, CB, CA} = a2g;

    x7seg X7(.data(x),
             .clk (CLK100MHZ),
             .clr (SW[0]),
             .a2g (a2g),
             .an  (AN),
             .dp  (DP)  );
endmodule
