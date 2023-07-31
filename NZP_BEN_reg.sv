module NZP_reg
     (input logic Clk, LD_CC, Reset, 
                input logic [15:0] BUS_In,
                output logic [2:0] NZP_Out);

    always_ff @ (posedge Clk)
		begin
				if(Reset) 
					NZP_Out <= 3'b000;
				else if(LD_CC)
                    if (BUS_In[15]) 
                        NZP_Out <= 3'b100;
                    else if (BUS_In == 16'h0000)
                        NZP_Out <= 3'b010;
                    else
                        NZP_Out <= 3'b001;
		end

endmodule

module BEN_reg (input logic Clk, LD_BEN, Reset,
    input logic [15:0] IR_In,
    input logic [2:0] NZP_In,
    output logic BEN_Out);

    always_ff @ (posedge Clk)
    begin
        if(Reset)
            BEN_Out <= 1'b0;
        else if (LD_BEN)
            BEN_Out <= (IR_In[11] & NZP_In[2] | IR_In[10] & NZP_In[1] | IR_In[9] & NZP_In[0]);
    end

endmodule