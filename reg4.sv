module reg4 (
	input logic [3:0] in,
	input logic slow_clock,
	input logic resetb,
	input logic load,
	
	output logic [3:0] out
	);
	
	//Block: Helps to decide if we can load things or not/
	always_ff @(posedge slow_clock) begin// waits for a rising edge
		if(!resetb)
			out <= 0;
			
		else if(load == 1)// if load == 1, than we update the register to that value.
			out <= in;
			
		else 
			out <= out; // if load is not 1 than the register stored in stays the same.
		end
		
endmodule
			
	