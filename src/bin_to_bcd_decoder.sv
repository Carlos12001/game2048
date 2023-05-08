module bin_to_bcd_decoder(
    input [3:0] bin_number,
    output reg [6:0] bcd_number
);

always @(*) begin
    case(bin_number)	
		//									 abcdefg
		0: 			bcd_number = 7'b0000001; //0
		1: 			bcd_number = 7'b1001111; //1
		2: 			bcd_number = 7'b0010010; //2
		3: 			bcd_number = 7'b0000110; //3
		4: 			bcd_number = 7'b1001100; //4
		5: 			bcd_number = 7'b0100100; //5
		6: 			bcd_number = 7'b0100000; //6
		7: 			bcd_number = 7'b0001111; //7
		8: 			bcd_number = 7'b0000000; //8
		9: 			bcd_number = 7'b0001100; //9
		default: 	bcd_number = 7'b1111111; //default to 0
    endcase
end

endmodule