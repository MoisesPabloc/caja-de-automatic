
module clock_divider #(parameter DIV = 25_000_000)(
    input clk,
    output reg slow_clk = 0
);
    // Tamaño mínimo necesario para contar hasta DIV
    reg [$clog2(DIV)-1:0] counter = 0;

    always @(posedge clk) begin
        if (counter >= DIV - 1) begin
            slow_clk <= ~slow_clk;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
