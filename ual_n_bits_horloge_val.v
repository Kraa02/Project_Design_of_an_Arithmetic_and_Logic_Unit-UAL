`timescale 10 ns / 1 ns

module timeScaleVal;

  real half_period;
  reg clock;

  initial begin
    clock = 0;
    half_period = 5.99999;
  end

  always
    begin
    #half_period;
    clock <= ~clock;
  end

endmodule