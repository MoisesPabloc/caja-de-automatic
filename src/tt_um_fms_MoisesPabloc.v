module tt_um_fms_MoisesPabloc (
    input  wire [7:0] ui,     // Inputs
    output wire [7:0] uo,     // Outputs (7-segment, active-low)
    inout  wire [7:0] uio,    // Bidirectional (unused)
    input  wire       clk,    // Clock (25kHz)
    input  wire       ena,    // Always high when active
    input  wire       rst_n   // Active-low reset
);

    // Asignación de señales claras
    wire reset       = ui[0];
    wire shift_up    = ui[1];
    wire shift_down  = ui[2];
    wire brake       = ui[3];

    wire [6:0] segments;
    
    // Conecta tu módulo FSM aquí
    gearbox_fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .segments(segments)  // salida de 7 segmentos (activo bajo)
    );

    assign uo[6:0] = segments;
    assign uo[7]   = 1'b1;     // no usado
    assign uio     = 8'bz;     // pines bidireccionales no utilizados

endmodule
