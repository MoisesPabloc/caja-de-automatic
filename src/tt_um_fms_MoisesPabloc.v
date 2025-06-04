module tt_um_fms_MoisesPabloc (
    input  wire [7:0] uio_in,      // Entradas físicas (GPIO inputs)
    output wire [7:0] uio_out,     // Salidas físicas (GPIO outputs)
    output wire [7:0] uio_oe,      // Control de salida (Output Enable)
    input  wire       clk,         // Reloj 25kHz
    input  wire       ena,         // Enable (puede ser constante 1)
    input  wire       rst_n        // Reset activo bajo
);

    // Señales internas
    wire reset      = ~rst_n;        // Invierto reset porque la FSM usa reset activo alto
    wire shift_up   = uio_in[0];
    wire shift_down = uio_in[1];
    wire brake      = uio_in[2];

    wire [6:0] segments;

    // Instancia FSM
    gearbox_fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .segments(segments)  // salida 7 segmentos (activo bajo)
    );

    // Asignar segmentos a salidas físicas y habilitar salida
    assign uio_out[6:0] = segments;
    assign uio_out[7] = 1'b0;        // No usado

    assign uio_oe = 8'b11111111;     // Habilitar todas las salidas para evitar error

endmodule
