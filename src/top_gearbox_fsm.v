
module top_gearbox_fsm(
    input clk,
    input reset,
    input shift_up,
    input shift_down,
    input brake,
    output [6:0] seg,
    output reg anode0
);

    wire slow_clk;

    clock_divider #(25_000_000) div_inst(
        .clk(clk),
        .slow_clk(slow_clk)
    );

    gearbox_fsm fsm_inst(
        .clk(slow_clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .seg(seg)
    );

    // Activamos solo el primer dígito (AN0)
    always @(*) begin
        anode0 = 0;  // Activo en bajo
    end

endmodule
