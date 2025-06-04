
module gearbox_fsm(
    input clk, reset, shift_up, shift_down, brake,
  
    output reg [6:0] seg
);

    typedef enum reg [3:0] {
        P_STATE = 4'd0,
        R_STATE = 4'd1,
        N_STATE = 4'd2,
        G1 = 4'd3,
        G2 = 4'd4,
        G3 = 4'd5,
        G4 = 4'd6,
        G5 = 4'd7,
        G6 = 4'd8
    } gear_state;

    gear_state current_state, next_state;

    // Moore Output Logic
    always @(*) begin
        case (current_state)
            P_STATE: seg = 7'b0111000; // P
            R_STATE: seg = 7'b0101111; // R
            N_STATE: seg = 7'b0111011; // N
            G1: seg = 7'b0000110; // 1
            G2: seg = 7'b1011011; // 2
            G3: seg = 7'b1001111; // 3
            G4: seg = 7'b1100110; // 4
            G5: seg = 7'b1101101; // 5
            G6: seg = 7'b1111101; // 6
            default: seg = 7'b1111111;
        endcase
    end

    // Mealy Transition Logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            P_STATE:
                if (shift_up && brake) next_state = R_STATE;
            R_STATE:
                if (shift_up && brake) next_state = N_STATE;
            N_STATE:
                if (shift_up) next_state = G1;
                else if (shift_down && brake) next_state = R_STATE;
            G1:
                if (shift_up) next_state = G2;
                else if (shift_down) next_state = N_STATE;
            G2:
                if (shift_up) next_state = G3;
                else if (shift_down) next_state = G1;
            G3:
                if (shift_up) next_state = G4;
                else if (shift_down) next_state = G2;
            G4:
                if (shift_up) next_state = G5;
                else if (shift_down) next_state = G3;
            G5:
                if (shift_up) next_state = G6;
                else if (shift_down) next_state = G4;
            G6:
                if (shift_down) next_state = G5;
        endcase
    end

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= P_STATE;
        else
            current_state <= next_state;
    end

endmodule
