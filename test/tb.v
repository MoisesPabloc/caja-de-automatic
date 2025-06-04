`default_nettype none
`timescale 1ns / 1ps

module tb ();

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  wire [7:0] uo_out;
  wire [7:0] uio_inout;

  tt_um_fms_MoisesPabloc dut (
      .ui_in   (ui_in),
      .uo_out  (uo_out),
      .uio_inout(uio_inout),
      .ena     (ena),
      .clk     (clk),
      .rst_n   (rst_n)
  );

  initial begin
    clk = 0;
    rst_n = 0;
    ena = 1;
    ui_in = 8'b0;
    #50 rst_n = 1;  // Salir de reset
  end

  always #20 clk = ~clk; // Reloj 25kHz, ajusta periodo si quieres

endmodule
