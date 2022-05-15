`timescale 10 ns / 1ns
module timeScaleVal;
  reg[31:0] rval;

  initial begin
    rval = 20;
    #10.566601 rval = 10;
    #10.980003 rval = 55;
    #15.674 rval = 0;
    #5.0000001 rval = 250;
    #5.67891224 rval = 100;
  end

  initial begin
    $monitor("TimeScale 1 ps/1 ps : Time=%0t, rval = %d\n",$realtime,rval);
    #100 $finish;
  end

endmodule