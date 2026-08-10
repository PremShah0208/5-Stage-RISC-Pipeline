module control_unit(
    input [6:0] opcode,
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg alu_src,
    output reg mem_to_reg
);

    always @(*) begin
        case (opcode)

            7'b0000011: begin // LW
                mem_read   = 1;
                mem_write  = 0;
                reg_write  = 1;
                alu_src    = 1;
                mem_to_reg = 1;
            end

            7'b0100011: begin // SW
                mem_read   = 0;
                mem_write  = 1;
                reg_write  = 0;
                alu_src    = 1;
                mem_to_reg = 0;
            end

            7'b0110011: begin // R-type (ADD/SUB)
                mem_read   = 0;
                mem_write  = 0;
                reg_write  = 1;
                alu_src    = 0;
                mem_to_reg = 0;
            end

            default: begin
                mem_read   = 0;
                mem_write  = 0;
                reg_write  = 0;
                alu_src    = 0;
                mem_to_reg = 0;
            end

        endcase
    end

endmodule
