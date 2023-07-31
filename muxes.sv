module mux_to_bus ( input logic [3:0] select,
        input logic [15:0] PC, MDR, MARMUX, ALU,
        output logic [15:0] BusOut );

        always_comb
        begin
            unique case (select)
                4'b1000 : BusOut = PC;
                4'b0100 : BusOut = MDR;
                4'b0010 : BusOut = MARMUX;
                4'b0001 : BusOut = ALU;
                default : BusOut = 16'hxxxx;
            endcase
        end

endmodule

module four_to_one_mux ( input logic [1:0] select,
        input logic [15:0] A, B, C, D,
        output logic [15:0] OUT );
        
        always_comb
        begin
            unique case (select)
                2'b00 : OUT = A;
                2'b01 : OUT = B;
                2'b10 : OUT = C;
                2'b11 : OUT = D;
                default : OUT = 16'hxxxx;
            endcase
        end

endmodule

module two_to_one_mux ( input logic select,
        input logic [15:0] A, B,
        output logic [15:0] OUT );
        
        always_comb
        begin
            unique case (select)
                1'b0 : OUT = A;
                1'b1 : OUT = B;
                default : OUT = 16'hxxxx;
            endcase
        end

endmodule

module two_to_one_mux_3bit ( input logic select,
        input logic [3:0] A, B,
        output logic [3:0] OUT );
        
        always_comb
        begin
            unique case (select)
                1'b0 : OUT = A;
                1'b1 : OUT = B;
                default : OUT = 3'bxxx;
            endcase
        end

endmodule
