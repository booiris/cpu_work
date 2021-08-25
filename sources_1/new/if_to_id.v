`timescale 1ns / 1ps
`include "defines.vh"


// 本模块为取指阶段到译码阶段传递指令的过程

module if_to_id(
         // if 取指阶段 id 译码阶段
         input wire clk,
         input wire rst,
         input wire[`inst_addr_bus] if_pc,
         input wire[`inst_bus] if_inst,

         output reg[`inst_addr_bus] id_pc,
         output reg[`inst_bus] id_inst
       );

always @(posedge clk)
  begin
    if (rst == `rst_enable)
      begin
        id_pc <= `zero_v;
        id_inst <= `zero_v;
      end
    else
      begin
        id_pc <= if_pc;
        id_inst <= if_inst;
      end
  end

endmodule
