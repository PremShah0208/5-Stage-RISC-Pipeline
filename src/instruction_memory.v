module instruction_memory(
    input [31:0] addr,
    output reg [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin
        memory[0] = 32'b00000000000100010000000010110011; // ADD x1, x2, x1 (example)
        memory[1] = 32'b00000000001000100001000110110011; // SUB x3, x4, x2
        memory[2] = 32'b00000000010000010010001000100011; // SW x4, 4(x2)
        memory[3] = 32'b00000000010100010000001110000011; // LW x7, 5(x2)
        memory[4] = 32'b00000000000000000000000000000000; // NOP
    end

    always @(*) begin
        instruction = memory[addr[9:2]]; // word aligned
    end

endmodule
