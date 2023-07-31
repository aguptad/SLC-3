module datapath (input logic LD_MAR, LD_PC, LD_MDR, LD_IR, LD_CC, LD_BEN, LD_REG, LD_LED,
    input logic GatePC, GateMDR, GateMARMUX, GateALU,
    input logic [1:0] PCMUX, ADDR2MUX, ALUK,
    input logic Clk, Reset, Run, Continue,
    input logic MIO_EN, DRMUX, SR1MUX, ADDR1MUX, SR2MUX,
    input logic [15:0] MDR_In,
    output logic [9:0] LEDS,
    output logic BEN,
    output logic [15:0] MAR, MDR, IR, PC);

    logic [15:0] BUS; 
    logic [15:0] mdr_mux_out, pc_mux_out;
    logic [2:0] NZP;
    
    logic [2:0] dr_mux_out, sr1_mux_out;

    logic [15:0] sr1_reg_out, sr2_reg_out, sr2_mux_out;

    logic [15:0] addr2_mux_out, addr1_mux_out, alu_unit_out;

    logic [15:0] addr_muxes_sum;

    mux_to_bus BUS_MUX(.select({GatePC, GateMDR, GateMARMUX, GateALU}), .MDR(MDR), .PC(PC), .MARMUX(addr_muxes_sum), .ALU(alu_unit_out), .BusOut(BUS));

    reg_16 REG_MAR(.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .D(BUS), .Data_Out(MAR));
    
    reg_16 REG_PC(.Clk(Clk), .Reset(Reset), .Load(LD_PC), .D(pc_mux_out), .Data_Out(PC));

    four_to_one_mux PC_MUX(.select(PCMUX), .A(PC + 1), .B(BUS), .C(addr_muxes_sum), .OUT(pc_mux_out));

    reg_16 REG_MDR(.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .D(mdr_mux_out), .Data_Out(MDR));
    two_to_one_mux MDR_MUX(.select(MIO_EN), .A(BUS), .B(MDR_In), .OUT(mdr_mux_out));

    reg_16 REG_IR(.Clk(Clk), .Reset(Reset), .Load(LD_IR), .D(BUS), .Data_Out(IR));
 
    NZP_reg REG_NZP(.Clk(Clk), .Reset(Reset), .LD_CC(LD_CC), .BUS_In(BUS), .NZP_Out(NZP));
    
    BEN_reg REG_BEN(.Clk(Clk), .Reset(Reset), .LD_BEN(LD_BEN), .IR_In(IR), .NZP_In(NZP), .BEN_Out(BEN));
    
    register_file REG_FILE(.Clk(Clk), .Reset(Reset), .LD_REG(LD_REG), .BUS_In(BUS), .SR1_In(sr1_mux_out), .SR2_In(IR[2:0]), .DR_In(dr_mux_out), .SR1_Out(sr1_reg_out), .SR2_Out(sr2_reg_out));
    
    two_to_one_mux_3bit DR_MUX(.select(DRMUX), .A(IR[11:9]), .B(3'b111), .OUT(dr_mux_out));
    two_to_one_mux_3bit SR1_MUX(.select(SR1MUX), .A(IR[11:9]), .B(IR[8:6]), .OUT(sr1_mux_out));

    four_to_one_mux ADDR2_MUX(.select(ADDR2MUX), .A(16'h0000), .B({{10{IR[5]}}, IR[5:0]}), .C({{7{IR[8]}}, IR[8:0]}), .D({{5{IR[10]}}, IR[10:0]}), .OUT(addr2_mux_out));
    two_to_one_mux ADDR1_MUX(.select(ADDR1MUX), .A(PC), .B(sr1_reg_out), .OUT(addr1_mux_out));
    assign addr_muxes_sum = addr2_mux_out + addr1_mux_out;

    two_to_one_mux SR2_MUX(.select(SR2MUX), .A(sr2_reg_out), .B({{11{IR[4]}}, IR[4:0]}), .OUT(sr2_mux_out));

    ALU ALU_UNIT(.ALUK(ALUK), .SR1(sr1_reg_out), .SR2(sr2_mux_out), .ALU_Out(alu_unit_out));

    /* always_ff @ (posedge Clk) begin
        if (LD_LED) begin
            LEDS <= LEDS - 1'b1;
        end
        else if (Reset) begin
            LEDS <= 10'h3f;
        end
    end */

endmodule 