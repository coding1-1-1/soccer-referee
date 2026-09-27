// ============================================================
// 七段数码管译码器（SystemVerilog）
// ------------------------------------------------------------
// 输入 : digit
//          0~F            : 十六进制字符
//          SEG_BLANK/MINUS/PLUS/EQU : 专用字符（见 disp_pkg）
// 输出 : seg[6:0] = {a,b,c,d,e,f,g}，Nexys4 数码管低电平点亮，
//        因此输出为段码取反后的值
// ============================================================
module hex7seg
    import disp_pkg::*;
(
    input  logic [SEG_W-1:0] digit,
    output logic [6:0]       seg
);

    // 段码中 1 表示点亮某段，输出时取反（板载共阳、低电平有效）
    always_comb begin
        case (digit)
            5'h0:    seg = ~7'b1111110;   // 0
            5'h1:    seg = ~7'b0110000;   // 1
            5'h2:    seg = ~7'b1101101;   // 2
            5'h3:    seg = ~7'b1111001;   // 3
            5'h4:    seg = ~7'b0110011;   // 4
            5'h5:    seg = ~7'b1011011;   // 5
            5'h6:    seg = ~7'b1011111;   // 6
            5'h7:    seg = ~7'b1110000;   // 7
            5'h8:    seg = ~7'b1111111;   // 8
            5'h9:    seg = ~7'b1111011;   // 9
            5'hA:    seg = ~7'b1110111;   // A
            5'hB:    seg = ~7'b0011111;   // b
            5'hC:    seg = ~7'b1001110;   // C
            5'hD:    seg = ~7'b0111101;   // d
            5'hE:    seg = ~7'b1001111;   // E
            5'hF:    seg = ~7'b1000111;   // F
            SEG_BLANK: seg = ~7'b0000000; // 空白
            SEG_MINUS: seg = ~7'b0000001; // '-'  g段
            SEG_PLUS:  seg = ~7'b0000111; // '+'  e,f,g段
            SEG_EQU:   seg = ~7'b0001001; // '='  d,g段
            default:   seg = ~7'b0000000; // 其余按空白处理
        endcase
    end

endmodule : hex7seg
