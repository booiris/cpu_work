`timescale 1ns / 1ps
`include "defines.vh"


module sopc(
         input wire clk,
         input wire rst
       );

wire[`inst_addr_bus] inst_addr;
wire[`inst_bus] inst;
wire rom_ce;

open_mips openmips0(
            .clk(clk),
            .rst(rst),
            .rom_addr_o(inst_addr),
            .rom_data_i(inst),
            .rom_ce(rom_ce)
          );

instruction_rom inst_rom0(
                  .ce(rom_ce),
                  .addr(inst_addr),
                  .inst(inst)
                );

endmodule
