class count_sb;

  event DONE;

  count_trans sb_data;
  count_trans rf_data;
  count_trans cov_data;

  int ref_data, dut_data, data_verified;
  int true_val = 0, false_val = 0;

  mailbox #(count_trans) rm2sb;
  mailbox #(count_trans) mon2sb;

  covergroup mem_coverage;
    DATA: coverpoint cov_data.data_in{
      bins LOW = {[0:4]};
      bins MID = {[5:8]};
      bins HIGH = {[9:12]};}
    LOAD: coverpoint cov_data.load{
      bins LOW = {0};
      bins HIGH ={1};}
    UP_DOWN: coverpoint cov_data.up_down{
      bins LOW = {0};
      bins HIGH ={1};}
    RST: coverpoint cov_data.resetn{
      bins LOW = {0};
      bins HIGH ={1};}
    COUNT: coverpoint cov_data.count{
      bins LOW = (0=>12);
      bins HIGH = (12=>0);}

    LOADXDATA: cross LOAD, DATA, RST, UP_DOWN;
    LOADXDATA1: cross LOAD, DATA, RST;
    LOADXDIR: cross LOAD, UP_DOWN, RST;
  endgroup

  function new(mailbox #(count_trans) rm2sb, mailbox #(count_trans) mon2sb);
    this.rm2sb  = rm2sb;
    this.mon2sb = mon2sb;
    mem_coverage = new();
  endfunction

  virtual task check(count_trans r_data);
    if(r_data.count == rf_data.count)
      begin
      $display ("Count Matches");
      true_val++;
      end
    else begin
      $display ("Count Not Maching");
      false_val++;
    end

    cov_data = new rf_data;
    mem_coverage.sample();

    data_verified++;

    if(data_verified == no_of_transactions)
      ->DONE;
  endtask

  virtual task start();
    fork
      while(1)
        begin
          rm2sb.get(rf_data);
          ref_data++;

          mon2sb.get(sb_data);
          dut_data++;

          check (sb_data);
        end
    join_none
  endtask

  virtual function void report();
    $display ("---------------------------------SCOREBOARD REPORT---------------------------------");
    $display ("Data_expected = %0d Data_generated = %0d Data_verified=%0d, True = %0d, False = %0d", ref_data, dut_data, data_verified, true_val, false_val);
    $display("------------------------------------------------------------------------------------");
    $display("DATA coverage     = %0.2f %%", mem_coverage.DATA.get_coverage());
    $display("LOAD coverage     = %0.2f %%", mem_coverage.LOAD.get_coverage());
    $display("UP_DOWN coverage  = %0.2f %%", mem_coverage.UP_DOWN.get_coverage());
    $display("RST coverage      = %0.2f %%", mem_coverage.RST.get_coverage());
    $display("COUNT coverage    = %0.2f %%", mem_coverage.COUNT.get_coverage());
    $display("CROSS coverage 1  = %0.2f %%", mem_coverage.LOADXDATA.get_coverage());
    $display("CROSS coverage 2  = %0.2f %%", mem_coverage.LOADXDATA1.get_coverage());
    $display("CROSS coverage 3  = %0.2f %%", mem_coverage.LOADXDIR.get_coverage());

  endfunction

endclass

