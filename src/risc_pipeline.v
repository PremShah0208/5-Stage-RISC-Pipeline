module risc_pipeline(
    input clk
);

    wire [31:0] instruction;
    wire [31:0] pc;
    wire [31:0] alu_result;
    wire [31:0] mem_data;
    wire [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    wire mem_read;
    wire mem_write;
    wire reg_write;
    wire alu_src;
    wire mem_to_reg;

    reg [31:0] PC = 0;

    instruction_memory imem(
        .addr(PC),
        .instruction(instruction)
    );

    register_file regs(
        .clk(clk),
        .reg_write(reg_write),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    control_unit ctrl(
        .opcode(instruction[6:0]),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg)
    );

    wire [31:0] alu_b =
        alu_src ? instruction[31:20] : read_data2;

    alu alu1(
        .a(read_data1),
        .b(alu_b),
        .alu_ctrl(4'b0000),
        .result(alu_result)
    );

    data_memory dmem(
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(read_data2),
        .read_data(mem_data)
    );

    assign write_data =
        mem_to_reg ? mem_data : alu_result;

    always @(posedge clk) begin
        PC <= PC + 4;
    end

endmodule
