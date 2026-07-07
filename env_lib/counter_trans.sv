class count_trans;

  // Signals
  rand logic [3:0] data_in;
  rand logic load;
  rand logic up_down;
  rand logic resetn;
  logic [3:0] count;

  // Constraints
  constraint C1 {data_in inside {[0:12]};}
  constraint C2 {resetn dist{0:=10, 1:=90};}
  constraint C3 {up_down dist{0:=50, 1:=50};}
  constraint C4 {load dist{0:=70, 1:=30};}
  //constraint C_reset {if (!resetn) load == 0;}

  virtual function void display(input string s);
    begin
      $display ("--------------------------------%s--------------------------------",s);
      $display ("up_down = %d", up_down);
      $display ("load = %d", load);
      $display ("data_in = %d", data_in);
      $display ("count = %d", count);
      $display ("resetn = %d", resetn);
      $display ("-------------------------------------------------------------------");
    end
  endfunction

endclass
