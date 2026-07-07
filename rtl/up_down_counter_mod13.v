module counter(
  input clock,
  input [3:0] din,
  input load, up_down, resetn,
  output reg [3:0] count);

  always @(posedge clock)
    begin
      if(!resetn)
        count <= 4'b0000;
      else if (load)
        count <= din;
      else if (up_down == 0)
        begin
          if (count == 12)
            count <= 4'b0000;
          else
            count <= count+1'b1;
        end
      else if (up_down == 1)
        begin
          if(count==0)
            count <= 4'b1100;
          else
            count <= count-1'b1;
        end
    end
endmodule
