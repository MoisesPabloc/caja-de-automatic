module tt_um_fms_MoisesPabloc (
    input  wire [7:0] ui_in,       // Entradas físicas (GPIO inputs)
    output wire [7:0] uo_out,      // Salidas físicas (GPIO outputs)
    input  wire [7:0] uio_in,      // GPIO entrada bidireccional (entrada)
    output wire [7:0] uio_out,     // GPIO salida bidireccional (salida)
    output wire [7:0] uio_oe,      // GPIO output enable (1 = salida)
    input  wire       clk,          // Reloj rápido (ej. 1MHz)
    input  wire       ena,          // Enable (puede ser constante 1)
    input  wire       rst_n         // Reset activo bajo
);

    wire slow_clk;
    wire reset      = ~rst_n;       // FSM usa reset activo alto
    wire shift_up   = ui_in[1];
    wire shift_down = ui_in[2];
    wire brake      = ui_in[3];

    wire [6:0] segments;

    // Divisor de reloj para obtener 25kHz de clk rápido (ej. 1MHz / 20_000)
    clock_divider #(.DIVIDE_BY(20000)) clk_div (
        .clk(clk),
        .slow_clk(slow_clk)
    );

    // FSM con slow_clk
    gearbox_fsm fsm_inst (
        .clk(slow_clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .seg(segments)
    );

    assign uo_out[6:0] = segments;
    assign uo_out[7]   = 1'b0;      // No usado

    // No usamos GPIO bidireccional, se dejan como entrada y salida deshabilitada
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
