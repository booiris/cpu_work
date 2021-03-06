`timescale 1ns / 1ps
`include "defines.vh"

module instruction_rom(
         input wire ce,
         input wire[`inst_addr_bus] addr,
         output reg[`inst_bus] inst
       );

reg[`inst_bus] inst_mem[0:10023];

initial
  $readmemh("data.mem", inst_mem);

reg[4:0] i;
reg[`inst_bus] temp;

always @(*)
  begin
    if(ce==`chip_disable)
      begin
        inst<=`zero_v;
      end
    else
      begin
        // for (i=0;i<=7;i=i+1)
        //   $display("%h",inst_mem[i]);
        temp = addr >> 2;
        // $display("%d",addr);
        // $display("%d",temp);
        inst<= inst_mem[temp];
        // $display("%h",inst);
      end
  end

endmodule
