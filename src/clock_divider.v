module clock_divider #(parameter DIVIDE_BY = 20_000) (  // Divide 1MHz a 25kHz
    input  wire clk,
    output reg  slow_clk = 0
);
    reg [31:0] counter = 0;

    always @(posedge clk) begin
        if (counter == DIVIDE_BY - 1) begin
            counter  <= 0;
            slow_clk <= ~slow_clk;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
