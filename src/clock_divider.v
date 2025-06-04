module clock_divider #(parameter DIVIDE_BY = 2) (
    input clk,
    output reg slow_clk
);
    reg [31:0] counter = 0;

    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == DIVIDE_BY - 1) begin
            counter <= 0;
            slow_clk <= ~slow_clk;
        end
    end
endmodule
