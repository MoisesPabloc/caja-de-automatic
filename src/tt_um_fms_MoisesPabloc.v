module tt_um_fms_MoisesPabloc (
    input  wire [7:0] ui_in,        // Entradas físicas (GPIO inputs)
    output wire [7:0] uo_out,       // Salidas físicas (GPIO outputs)
    inout  wire [7:0] uio_inout,    // GPIO bidireccional (no usado aquí)
    input  wire       clk,           // Reloj rápido (ej. 1MHz)
    input  wire       ena,           // Enable (puede ser constante 1)
    input  wire       rst_n          // Reset activo bajo
);

    wire slow_clk;
    wire reset      = ~rst_n;         // FSM usa reset activo alto
    wire shift_up   = ui_in[1];
    wire shift_down = ui_in[2];
    wire brake      = ui_in[3];

    wire [6:0] segments;

    // Instancia del divisor de reloj: reduce clk rápido a slow_clk 25kHz
    clock_divider #(.DIVIDE_BY(20_000)) clk_div (
        .clk(clk),
        .slow_clk(slow_clk)
    );

    // Instancia FSM con slow_clk
    gearbox_fsm fsm_inst (
        .clk(slow_clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .seg(segments)
    );

    // Asignar segmentos a salidas físicas y habilitar salida
    assign uo_out[6:0] = segments;
    assign uo_out[7]   = 1'b0;        // No usado

    assign uio_inout = 8'bz;          // No usados bidireccional

endmodule
