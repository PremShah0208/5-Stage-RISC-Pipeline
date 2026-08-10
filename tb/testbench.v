module testbench;

    reg clk = 0;

    risc_pipeline uut(
        .clk(clk)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, uut);

        #100 $finish;
    end

endmodule
