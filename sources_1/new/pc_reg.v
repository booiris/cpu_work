`timescale 1ns / 1ps
`include "defines.v"

// 本模块为取指令

module pc_reg(
         input wire clk,
         input wire rst,

         output reg[`inst_addr_bus] pc,
         output reg ce
       );

always @(posedge clk)
  begin
    if (rst == `rst_enable)
      begin
        ce <= `chip_disable; // 复位时模块禁止使用
      end
    else
      begin
        ce <= `chip_enable;
      end
  end

always @(posedge clk)
  begin
    if(ce == `chip_disable)
      begin
        pc<=`zero_v;
      end
    else
      begin
        pc<=pc+4'h4;
      end
  end

endmodule
