`timescale 1ns / 1ps
`include "defines.vh"


module ex_to_mem(
         input wire clk,
         input wire rst,
         input wire[`reg_bus] ans_i,
         input wire write_enable_i,
         input wire[`reg_addr_bus] write_addr_i,

         output reg[`reg_bus] ans_o,
         output reg write_enable_o,
         output reg[`reg_addr_bus] write_addr_o

       );

always @(posedge clk)
  begin
    if(rst == `rst_enable)
      begin
        write_enable_o <= `false_v;
      end
    else
      begin
        ans_o <= ans_i;
        write_enable_o <= write_enable_i;
        write_addr_o <= write_addr_i;
      end
  end

endmodule
