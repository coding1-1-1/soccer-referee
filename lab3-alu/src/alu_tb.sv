// ============================================================
// ALU 仿真测试文件（SystemVerilog）
// 运行（vivado xsim 直接跑；iverilog 用 -g2012）:
//   iverilog -g2012 -o alu_tb alu.sv alu_tb.sv && vvp alu_tb
// ============================================================
`timescale 1ns/1ps

module alu_tb;

    logic [3:0] a, b;
    logic       cin, m;
    logic [1:0] s;
    logic [3:0] f;
    logic       cout;
    int         errors;

    alu dut (
        .a(a), .b(b), .cin(cin), .m(m), .s(s),
        .f(f), .cout(cout)
    );

    // 自检测试任务：比对 {cout, f} 与期望值
    task automatic check(logic [4:0] exp, string name);
        if ({cout, f} !== exp) begin
            errors++;
            $display("FAIL %s : a=%h b=%h cin=%b m=%b s=%b -> cout=%b f=%h (期望 cout=%b f=%h)",
                     name, a, b, cin, m, s, cout, f, exp[4], exp[3:0]);
        end else begin
            $display("PASS %s : cout=%b f=%h", name, cout, f);
        end
    endtask

    initial begin
        errors = 0;

        // ---------------- 位运算 (m=0) ----------------
        m = 1'b0; cin = 1'b0;
        a = 4'hA; b = 4'h5;
        s = 2'b00; #10 check({1'b0, ~4'hA}, "not A   ");
        s = 2'b01; #10 check({1'b0, 4'hA & 4'h5}, "A and B ");
        s = 2'b10; #10 check({1'b0, 4'hA | 4'h5}, "A or B  ");
        s = 2'b11; #10 check({1'b0, 4'hA ^ 4'h5}, "A xor B ");

        // ---------------- 算术运算 (m=1) ----------------
        m = 1'b1;

        // 加法: F = A + B + Cin
        s = 2'b00;
        a = 4'd9;  b = 4'd6;  cin = 1'b0; #10 check(5'd15, "9+6+0   ");   // 无进位
                  cin = 1'b1; #10 check(5'd16, "9+6+1   ");              // 有进位 f=0
        a = 4'd15; b = 4'd15; cin = 1'b1; #10 check(5'd31, "F+F+1   ");  // 最大进位
        a = 4'd0;  b = 4'd0;  cin = 1'b0; #10 check(5'd0,  "0+0+0   ");

        // 减法: F = A - B - Cin（题目要求 A > B，cout=1 表示无借位）
        s = 2'b01;
        a = 4'd9; b = 4'd4; cin = 1'b0; #10 check(5'd21, "9-4-0   ");   // 9+~4+1=21:  f=5,  cout=1(无借位)
                 cin = 1'b1; #10 check(5'd20, "9-4-1   ");              // 9+~4+0=20:  f=4,  cout=1
        a = 4'd8; b = 4'd1; cin = 1'b0; #10 check(5'd23, "8-1-0   ");   // 8+~1+1=23:  f=7,  cout=1
        a = 4'd3; b = 4'd5; cin = 1'b0; #10 check(5'd14, "3-5-0   ");   // A<B(超出题目范围): f=E, cout=0(有借位)

        // 未规定功能: 输出 0
        s = 2'b10; #10 check(5'd0, "未定10  ");
        s = 2'b11; #10 check(5'd0, "未定11  ");

        // ---------------- 结果汇总 ----------------
        if (errors == 0)
            $display("==== 全部测试通过 ====");
        else
            $display("==== %0d 个测试失败 ====", errors);
        $finish;
    end

endmodule : alu_tb
