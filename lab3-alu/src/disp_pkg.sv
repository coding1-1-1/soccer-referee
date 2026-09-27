// ============================================================
// 实验 3：显示字符编码包（SystemVerilog package）
// ------------------------------------------------------------
// 七段数码管 5 位显示码定义：
//   0~F : 十六进制字符
//   BLANK / MINUS / PLUS / EQU : 专用字符（见 hex7seg.sv）
// ============================================================
package disp_pkg;

    localparam int SEG_W = 5;   // 显示码位宽

    typedef enum logic [SEG_W-1:0] {
        SEG_BLANK = 5'h10,      // 空白
        SEG_MINUS = 5'h11,      // '-'
        SEG_PLUS  = 5'h12,      // '+'
        SEG_EQU   = 5'h13       // '='
    } seg_char_e;

endpackage : disp_pkg
