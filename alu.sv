module ALU (input logic [15:0] SR1,
            input logic [15:0] SR2,
            input logic [1:0] ALUK,
            output logic [15:0] ALU_Out );

    always_comb
    begin
        case (ALUK)
            2'b00 : ALU_Out = SR1 + SR2;
            2'b01 : ALU_Out = SR1 & SR2;
            2'b10 : ALU_Out = ~SR1;
            2'b11 : ALU_Out = SR1;
        endcase
    end

endmodule