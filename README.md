# Nexys4 DDR 数电实验合集（FPGA Labs）

基于 Nexys4 DDR 开发板（Xilinx FPGA）的数字电路实验合集，使用 Vivado 2022.2 + Verilog/SystemVerilog。

## 实验列表

| 实验 | 目录 | 内容 |
|---|---|---|
| 实验一：踢球裁决器 | [`lab1-soccer-referee/`](lab1-soccer-referee/) | 拨码开关输入、LED 输出裁决结果 |
| 实验二：七段数码管显示 | [`lab2-sevenseg-display/`](lab2-sevenseg-display/) | 4 位固定显示 `2026` 与 8 位动态扫描 |

每个 `labX` 目录下是独立的 Vivado 工程，用 Vivado 打开对应的 `.xpr` 文件即可。

## 使用方式

1. 克隆本仓库：`git clone https://github.com/coding1-1-1/fpga-labs.git`
2. 进入对应实验目录，用 Vivado 打开 `.xpr` 工程
3. 运行综合、实现并生成比特流，烧录到 Nexys4 DDR 开发板

> Vivado 自动生成的缓存、仿真和实现产物（`.cache/`、`.runs/`、`.sim/` 等）已通过 `.gitignore` 排除，克隆后用 Vivado 重新生成即可。实验报告统一线下提交，PDF 不会进入仓库。
