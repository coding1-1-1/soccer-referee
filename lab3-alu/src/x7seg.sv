// ============================================================
// 8 位七段数码管动态扫描驱动（SystemVerilog）
// ------------------------------------------------------------
// 输入 : clk 100MHz, clr 异步清零, data[39:0] = {d7,...,d0}
//        每个 d 为 SEG_W 位显示码（编码方式见 disp_pkg / hex7seg）
// 输出 : an[7:0]   位选，低电平选中
//        digit     当前选中位的显示码（送 hex7seg 译码）
//
// 扫描频率：100MHz / 100000 = 1kHz 换一位，
// 每位点亮约 1ms，整屏刷新约 125Hz，无闪烁。
// data 最低 SEG_W 位对应 an[0]（最右侧数码管）。
// ============================================================
module x7seg
    import disp_pkg::*;
(
    input  logic               clk,
    input  logic               clr,
    input  logic [8*SEG_W-1:0] data,
    output logic [7:0]         an,
    output logic [SEG_W-1:0]   digit
);

    localparam int DIV_N = 100_000;   // 分频系数（100MHz -> 1kHz）

    logic [16:0] cnt;                 // 分频计数
    logic        tick;
    logic [2:0]  q;                   // 扫描位序号

    assign tick = (cnt == DIV_N - 1);

    always_ff @(posedge clk or posedge clr) begin
        if (clr)      cnt <= '0;
        else if (tick) cnt <= '0;
        else          cnt <= cnt + 1'b1;
    end

    always_ff @(posedge clk or posedge clr) begin
        if (clr)       q <= '0;
        else if (tick) q <= q + 1'b1;
    end

    always_comb begin
        case (q)
            3'd0: begin an = 8'b1111_1110; digit = data[1*SEG_W-1 -: SEG_W]; end
            3'd1: begin an = 8'b1111_1101; digit = data[2*SEG_W-1 -: SEG_W]; end
            3'd2: begin an = 8'b1111_1011; digit = data[3*SEG_W-1 -: SEG_W]; end
            3'd3: begin an = 8'b1111_0111; digit = data[4*SEG_W-1 -: SEG_W]; end
            3'd4: begin an = 8'b1110_1111; digit = data[5*SEG_W-1 -: SEG_W]; end
            3'd5: begin an = 8'b1101_1111; digit = data[6*SEG_W-1 -: SEG_W]; end
            3'd6: begin an = 8'b1011_1111; digit = data[7*SEG_W-1 -: SEG_W]; end
            default: begin an = 8'b0111_1111; digit = data[8*SEG_W-1 -: SEG_W]; end
        endcase
    end

endmodule : x7seg
