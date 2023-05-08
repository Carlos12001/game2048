module bin_converter (
    input logic [19:0] bin,
    output logic [3:0] bin_units,
    output logic [3:0] bin_tens,
	output logic [3:0] bin_hundreds,
	output logic [3:0] bin_thousands,
	output logic [3:0] bin_ten_thousands,
	output logic [3:0] bin_hundred_thousands 
);

	function logic [15:0] to_decimal;
		 input logic [19:0] binary;
		 to_decimal =   binary[0]  +  2*binary[1]  +  4*binary[2]  + 
                        8*binary[3]  + 16*binary[4]  + 32*binary[5]  + 
                       64*binary[6] + 128*binary[7] + 256*binary[8] + 
                      512*binary[9] + 1024*binary[10] + 2048*binary[11] + 
                     4096*binary[12] + 8192*binary[13] + 16384*binary[14] + 
                    32768*binary[15] + 65536*binary[16] + 131072*binary[17] + 
                   262144*binary[18] + 524288*binary[19];
	endfunction

	logic [15:0] decimal_value;
	logic [3:0] units, tens, hundreds, thousands, ten_thousands, hundred_thousands;

	always_comb begin
		// Convertir el numero binario de 20 bits a un numero decimal
		decimal_value = to_decimal(bin);

		// Calcular las unidades, decenas, centenas, millares, decenas de millares y centenas de millares en decimal
		units = decimal_value % 10;
		tens = (decimal_value / 10) % 10;
		hundreds = (decimal_value / 100) % 10;
		thousands = (decimal_value / 1000) % 10;
		ten_thousands = (decimal_value / 10000) % 10;
		hundred_thousands = (decimal_value / 100000) % 10;

		// Convertir las unidades, decenas, centenas, millares, decenas de millares y centenas de millares a binario
		bin_units = units;
		bin_tens = tens;
		bin_hundreds = hundreds;
		bin_thousands = thousands;
		bin_ten_thousands = ten_thousands;
		bin_hundred_thousands = hundred_thousands;
	end

endmodule
