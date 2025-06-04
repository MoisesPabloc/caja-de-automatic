
module tt_um_fms_MoisesPabloc(
    input clk,
    input reset,
    input shift_up,
    input shift_down,
    input brake,
    output [6:0] seg,
    output reg [3:0] an
);
    wire slow_clk;

    clock_divider #(25_000_000) divider (
        .clk(clk),
        .slow_clk(slow_clk)
    );

    gearbox_fsm fsm (
        .clk(slow_clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .seg(seg)
    );

    // Solo un display encendido
    always @(*) begin
        an = 4'b1110;
    end
endmodule
