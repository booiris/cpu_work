`timescale 1ns / 1ps
`include "defines.vh"


module test_bench(
       );

reg CLOCK_50;
reg rst;


initial
  begin
    CLOCK_50 = 1'b0;
    forever
      #10 CLOCK_50 = ~CLOCK_50;
  end

initial
  begin
    rst = `rst_enable;
    #20 rst = `rst_disable;
    #1000 $stop;
  end

sopc sopc0(.clk(CLOCK_50),.rst(rst));


endmodule
