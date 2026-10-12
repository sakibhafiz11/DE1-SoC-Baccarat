module card7seg (
	
	input logic [3:0] SW,
	output logic [6:0] HEX0
	);
	
	always_comb begin
		case(SW)
			4'd0: HEX0 = 7'b1111111; //Output = Blank
			4'd1: HEX0 = 7'b0001000; //Output = 1(ACE)
			4'd2: HEX0 = 7'b0100100; //Output = 2
			4'd3: HEX0 = 7'b0110000; //Output = 3
			4'd4: HEX0 = 7'b0011001; //Output = 4
			4'd5: HEX0 = 7'b0010010; //Output = 5
			4'd6: HEX0 = 7'b0000010; //Output = 6
			4'd7: HEX0 = 7'b1111000; //Output = 7
			4'd8: HEX0 = 7'b0000000; //Output = 8
			4'd9: HEX0 = 7'b0010000; //Output = 9
			4'd10: HEX0 = 7'b1000000; //Output = 10
			4'd11: HEX0 = 7'b1100001; //Output = J
			4'd12: HEX0 = 7'b0011000; //Output = q
			4'd13: HEX0 = 7'b0001001; //Output = H
			4'd14: HEX0 = 7'b1111111; //Output = Blank
			4'd15: HEX0 = 7'b1111111; //Output = Blank
			default : HEX0 = 7'b1111111; //always should add a default for case
		endcase
	end
	
endmodule