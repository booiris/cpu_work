`timescale 1ns / 1ps
`include "defines.v"

// 本模块为 mips 中 32个寄存器的实现

module reg_build(
         input wire clk,
         input wire rst,

         input wire[`reg_addr_bus] reg1_addr,
         input wire reg1_read,
         output reg[`reg_bus] reg1_data,

         input wire[`reg_addr_bus] reg2_addr,
         input wire reg2_read,
         output reg[`reg_bus] reg2_data,

         input wire we,
         input wire[`reg_addr_bus] write_addr,
         output reg[`reg_bus] write_data

       );

reg[`reg_bus] regs[0:31]; // 定义 32 个寄存器

always @(*)
  begin
    if (rst == `rst_enable)
      begin
        reg1_data <= `zero_v;
      end
    else if (reg1_addr == 5'h0 || reg1_read == `false_v)
      begin
        reg1_data <= `zero_v;
      end
    else if(reg1_addr == write_addr && we == `true_v )
      begin
        reg1_data <= write_data;
      end
    else
      begin
        reg1_data <= regs[reg1_addr];
      end
  end

always @(*)
  begin
    if (rst == `rst_enable)
      begin
        reg2_data <= `zero_v;
      end
    else if (reg1_addr == 5'h0 || reg2_read == `false_v)
      begin
        reg2_data <= `zero_v;
      end
    else if(reg2_addr == write_addr && we == `true_v )
      begin
        reg2_data <= write_data;
      end
    else
      begin
        reg2_data <= regs[reg2_addr];
      end
  end

always @(posedge clk)
  begin
    if(rst == `rst_disable)
      begin
        if(we == `true_v && write_addr != 5'h0)
          begin
            regs[write_addr] <= write_data;
          end
      end
  end

endmodule
