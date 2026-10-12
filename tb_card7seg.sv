module tb_card7seg;
    logic [3:0] card;
    logic [6:0] display;

    card7seg test (
        .SW(card),
        .HEX0(display)
    );

    initial begin // we would be able to test these values
	 
	 card = 4'b0000; #10; //Ouput = (BLANK)
	 card = 4'b0001; #10; //Output = 1(ACE)
	 card = 4'b0010; #10; //Output = 2
	 card = 4'b0011; #10; //Output = 3
	 card = 4'b0100; #10; //Output = 4
	 card = 4'b0101; #10; //Output = 5
	 card = 4'b0110; #10; //Output = 6
	 card = 4'b0111; #10; //Output = 7
	 card = 4'b1000; #10; //Output = 8
	 card = 4'b1001; #10; //Output = 9
	 card = 4'b1010; #10; //Output = 10
	 card = 4'b1011; #10; //Output = 11 (JACK)
	 card = 4'b1100; #10; //Output = 12 (QUEEN)
	 card = 4'b1101; #10; //Output = 13 (KING)
	 card = 4'b1110; #10; //Output = 14 (BLANK)
	 card = 4'b1111; #10; //Output = 15 (BLANK)
	 $stop;
	 end
	 
endmodule