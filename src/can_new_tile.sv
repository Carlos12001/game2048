module can_new_tile (
    input logic [11:0] board_in [3:0][3:0],
    output logic result
);

  logic empty_space_found;

  // Verificar si hay espacio disponible en la matriz
  always_comb begin
    empty_space_found = 0;
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        if (board_in[i][j] == 0) begin
          empty_space_found = 1;
        end
      end
    end
  end

  assign result = empty_space_found;

endmodule
