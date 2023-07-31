module register_file (  input logic Clk, Reset, LD_REG,
                        input logic [15:0] BUS_In,
                        input logic [2:0] SR1_In, SR2_In, DR_In,
                        output logic [15:0] SR1_Out, SR2_Out );

    logic [15:0] registers [8];
    int i;

    always_ff @ (posedge Clk)
    begin
        if(LD_REG) 
            registers[DR_In] <= BUS_In;
        else if (Reset)
            for (i = 0; i < 8; i++) begin
                registers[i] = 16'h0000;
            end
    end

    always_comb begin
        SR1_Out = registers[SR1_In];
        SR2_Out = registers[SR2_In];
    end

endmodule