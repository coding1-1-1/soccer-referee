`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/09/13 10:42:32
// Design Name: 
// Module Name: ball_sim
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


module ball_sim();
    logic [15:0] sw;  // 输入端口变量
    logic [15:0] Led; // 输出端口变量
    // 实例化
    ball A(.SW(sw),    // 输入
           .LED(Led)); // 输出
    // 激励信号
    initial   // 只执行一次
    begin
        integer i;
        // 给sw[i]赋初值0
        for (i = 15; i >= 0; i=i-1)
            sw[i] = 0;
        // 裁决器只用到sw[15](晴天)和sw[0](有空),遍历四种组合
        // 每10ns换一种情况
        #10  sw[0]  = 1;               // 下雨,有空 -> 不去踢球
        #10  sw[0]  = 0;  sw[15] = 1;  // 晴天,没空 -> 不去踢球
        #10  sw[0]  = 1;               // 晴天,有空 -> LED[8]亮,去踢球
        #10  sw[15] = 0;  sw[0]  = 0;  // 回到下雨,没空
    end
endmodule
