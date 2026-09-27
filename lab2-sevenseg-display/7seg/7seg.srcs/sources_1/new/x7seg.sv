`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/11 11:30:22
// Design Name: 
// Module Name: x7seg
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


module x7seg( input  logic [15:0] data,
              input  logic        clk,
              input  logic        clr,
              output logic [6:0]  a2g,
              output logic [3:0]  an,
              output logic        dp );

    logic [1:0]  s;
    logic [3:0]  digit;
    logic [19:0] clkdiv;

    assign dp = 1'b1;               // 小数点常灭
    assign s  = clkdiv[19:18];      // 位切换约381Hz，整屏约95Hz

    // 数据选择：s指谁，端谁的4位
    always_comb
      case(s)
        2'd0:    digit = data[3:0];
        2'd1:    digit = data[7:4];
        2'd2:    digit = data[11:8];
        2'd3:    digit = data[15:12];
        default: digit = data[3:0];
      endcase

    // 位选译码：低有效，一次只开一扇门
    always_comb
      case(s)
        2'd0:    an = 4'b1110;
        2'd1:    an = 4'b1101;
        2'd2:    an = 4'b1011;
        2'd3:    an = 4'b0111;
        default: an = 4'b1111;      // 修订①
      endcase

    // 20位分频计数器，异步清零
    always_ff @(posedge clk or posedge clr) begin   // 修订②③
        if (clr) clkdiv <= 20'd0;
        else     clkdiv <= clkdiv + 1'b1;
    end

    // 译码器例化
    Hex7Seg H7(.digit(digit), .a2g(a2g));
endmodule