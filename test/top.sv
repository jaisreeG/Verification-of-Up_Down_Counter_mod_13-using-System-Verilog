module top;

  import count_pkg::*;

  bit clock;

  count_if DUV_IF(clock);

  test t_h;

  counter duv (
    .clock   (clock),
    .din     (DUV_IF.data_in),
    .load    (DUV_IF.load),
    .up_down (DUV_IF.up_down),
    .resetn  (DUV_IF.resetn),
    .count   (DUV_IF.count)
  );

  initial begin
    clock = 1'b0;
    forever #10 clock = ~clock;
  end

  initial begin
    no_of_transactions = 230;
    t_h = new(DUV_IF, DUV_IF, DUV_IF);
    t_h.build();
    t_h.run();
    $finish;
  end

endmodule
