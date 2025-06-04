module tt_um_fms_MoisesPabloc (
    input  wire [7:0] ui_in,      // Inputs
    output wire [7:0] uo_out,     // Outputs (7-segment, active-low)
    inout  wire [7:0] uio_inout,  // Bidirectional (unused)
    input  wire       clk,        // Clock (25kHz)
    input  wire       ena,        // Always high when active
    input  wire       rst_n       // Active-low reset
);

    // Asignación de señales claras
    wire reset       = ui_in[0];
    wire shift_up    = ui_in[1];
    wire shift_down  = ui_in[2];
    wire brake       = ui_in[3];

    wire [6:0] segments;
    
    // Instancia de la FSM
    gearbox_fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .shift_up(shift_up),
        .shift_down(shift_down),
        .brake(brake),
        .segments(segments)  // salida de 7 segmentos (activo bajo)
    );

    assign uo_out[6:0] = segments;
    assign uo_out[7]   = 1'b1;     // no usado
    assign uio_inout   = 8'bz;     // pines bidireccionales no utilizados

endmodule
