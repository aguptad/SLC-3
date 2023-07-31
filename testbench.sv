module testbench();

timeunit 10ns;    // Half clock cycle at 50 MHz
                // This is the amount of time represented by #1

timeprecision 1ns;


logic [9:0] SW;
logic  Clk, Run, Continue;
logic [15:0] PC;
logic [15:0] MAR, MDR, IR;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic [15:0] R1, R2, R3, R5;

slc3_testtop top(.*);

assign PC = top.slc.d0.PC; 
assign IR =  top.slc.d0.IR; 
assign MAR = top.slc.d0.MAR; 
assign MDR = top.slc.d0.MDR; 
assign R1 = top.slc.d0.REG_FILE.registers[1];
assign R2 = top.slc.d0.REG_FILE.registers[2];
assign R3 = top.slc.d0.REG_FILE.registers[3];
assign R5 = top.slc.d0.REG_FILE.registers[5];

initial begin
    Clk = 0;
end

always #1 Clk = ~Clk;


initial begin
// ----------------------------------------------------
// IO TEST 1

// Run = 1;
// Continue = 1;
// SW = 10'h3;

// #2
// Run = 0;
// Continue = 0;

// #2 //Resets pressed and set back to low
// Run = 1;
// Continue = 1;
// //Run is pressed
// #2 Run = 0;
// #2 Run = 1;

// ----------------------------------------------------
// IO TEST 2

// Run = 1;
// Continue = 1;
// SW = 10'h6;
// #2 Run = 0;
// Continue = 0;
// #2 Run = 1;
// Continue = 1;

// // Press Run
// #2 Run = 0;
// #2 Run = 1;

// #60 SW = 10'h7;

// #40 Continue = 0;
// #2 Continue = 1;

// #90 Continue = 0;
// #2 Continue = 1;

// ----------------------------------------------------
// XOR Test

// Run = 1;
// Continue = 1;
// SW = 10'h14;

// #2
// Run = 0;
// Continue = 0;

// #2 //Resets pressed and set back to low
// Run = 1;
// Continue = 1;

// //Run is pressed
// #2 Run = 0;
// #2 Run = 1;

// #90 Continue = 0;
// #2 Continue = 1;

// #30 SW = 10'hFF;

// #20 Continue = 0;
// #2 Continue = 1;

// ----------------------------------------------------
// Multiplier Test

// Run = 1;
// Continue = 1;
// SW = 10'h31;

// #2
// Run = 0;
// Continue = 0;

// #2 //Resets pressed and set back to low
// Run = 1;
// Continue = 1;

// //Run is pressed
// #2 Run = 0;
// #2 Run = 1;

// #170 Continue = 0;
// #2 Continue = 1;

// #40 SW = 10'h2;

// #2 Continue = 0;
// #2 Continue = 1;

// ----------------------------------------------------
// IO Test 3 (Self-Modifying Code)

// Run = 1;
// Continue = 1;
// SW = 10'hb;
// #2 Run = 0;
// Continue = 0;
// #2 Run = 1;
// Continue = 1;

// // Press Run
// #2 Run = 0;
// #2 Run = 1;

// #60 SW = 10'h7;

// #20 Continue = 0;
// #2 Continue = 1;

// #130 Continue = 0;
// #2 Continue = 1;

// #130 Continue = 0;
// #2 Continue = 1;

// ----------------------------------------------------
// Sort

Run = 1;
Continue = 1;
SW = 10'h5a;
#2 Run = 0;
Continue = 0;
#2 Run = 1;
Continue = 1;

// Press Run
#2 Run = 0;
#2 Run = 1;

#140 SW = 10'h2;

#5 Continue = 0;
#2 Continue = 1;

end

endmodule