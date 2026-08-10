module pipeline_registers(
    input clk,
    input [31:0] if_inst_in,
    input [31:0] if_pc_in,
    output reg [31:0] id_inst_out,
    output reg [31:0] id_pc_out
);

    always @(posedge clk) begin
        id_inst_out <= if_inst_in;
        id_pc_out <= if_pc_in;
    end

endmodule
