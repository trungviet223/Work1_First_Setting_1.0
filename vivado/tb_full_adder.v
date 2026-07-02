`timescale 1ns / 1ps

module tb_full_adder;

  reg [7:0] ui_in;
  wire [7:0] uo_out;
  reg [7:0] uio_in;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
  reg ena;
  reg clk;
  reg rst_n;

  integer i;
  reg expected_sum;
  reg expected_cout;

  tt_um_test_trungviet223_sys_full_adder dut (
      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

  initial begin
    clk = 0;
    ena = 1;
    rst_n = 1;
    ui_in = 0;
    uio_in = 0;

    for (i = 0; i < 8; i = i + 1) begin
      ui_in[2:0] = i[2:0];
      #10;

      expected_sum  = ui_in[0] ^ ui_in[1] ^ ui_in[2];
      expected_cout = (ui_in[0] & ui_in[1]) | (ui_in[0] & ui_in[2]) | (ui_in[1] & ui_in[2]);

      if ((uo_out[0] !== expected_sum) || (uo_out[1] !== expected_cout)) begin
        $display("FAIL: A=%b B=%b Cin=%b Sum=%b Cout=%b", ui_in[0], ui_in[1], ui_in[2], uo_out[0],
                 uo_out[1]);
        $finish;
      end
    end

    $display("PASS: all full-adder combinations are correct.");
    $finish;
  end

endmodule
