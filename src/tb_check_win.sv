`timescale 1ns / 1ps

module tb_check_win;

  localparam MAX_WIN = 11;

  logic [11:0] board_in[3:0][3:0];
  logic result;

  // Instancia del módulo check_win
  check_win #(.MAX_WIN(MAX_WIN)) test (
    .board_in(board_in),
    .result(result)
  );

  initial begin
    // Caso 1: Matriz llena de ceros
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        board_in[i][j] = 12'b0;
      end
    end
    #10; // Espera 10ns
    assert(result == 1'b0) else $fatal("Caso 1: Matriz llena de ceros. Resultado esperado: 0. Resultado obtenido: %b", result);

    // Caso 2: Un número 2048 en la matriz
    board_in[1][1] = 12'b100000000000;
    #10;
    assert(result == 1'b1) else $fatal("Caso 2: Un numero 2048 en la matriz. Resultado esperado: 1. Resultado obtenido: %b", result);

    // Caso 3: Un número 128 en la matriz
    board_in[1][1] = 12'b000000000000;
    board_in[2][1] = 12'b000001000000;
    #10;
    assert(result == 1'b0) else $fatal("Caso 3: Un numero 64 en la matriz. Resultado esperado: 0. Resultado obtenido: %b", result);

    $display("Testbench completo. Todos los casos de prueba pasaron.");
    $finish; // Termina la simulación
  end

endmodule
