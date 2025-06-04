module tt_um_fms_MoisesPabloc (
    input  [7:0] ui_in,    // Entradas: ui[0] = reset, ui[1] = shift_up, ui[2] = shift_down, ui[3] = brake
    output [7:0] uo_out,   // Salida a display 7 segmentos activo bajo
    input  [7:0] uio_in,   // Pines bidireccionales no usados
    output [7:0] uio_out,
    output [7:0] uio_oe,
    input        ena,      // señal enable (debe estar presente)
    input        clk,      // reloj principal (25kHz según YAML)
    input        rst       // reset global
);

    wire [6:0] seg;
    wire slow_clk;

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Mapeo de salidas del display
    assign uo_out[6:0] = seg;
    assign uo_out[7]   = 1'b0;  // no usado

    // Mapeo de entradas
    wire reset      = ui_in[0] | rst;  // usa reset externo o de plataforma
    wire shift_up   = ui_in[1];
    wire shift_down = ui_in[2];
    wire brake      = ui_in[3];

    // División de reloj (si se requiere)
    clock_divider #(1) divider (  // dividir entre 1 si usas 25kHz directamente
        .clk(clk),
        .slow_clk(slow_clk)
    );

    // Máquina de estados
    gearbox_fsm fsm (
        .clk(slow_clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .seg(seg)
    );

endmodule
