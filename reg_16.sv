module reg_16 (input  logic Clk, Reset, Load,
              input  logic [15:0]  D, // edit
              output logic [15:0]  Data_Out); // edit

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 16'h0; // edit
		 else if (Load)
			  Data_Out <= D;
    end

endmodule
