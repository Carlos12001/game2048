module tb_matriz;

  logic [11:0] matriz[0:3][0:3]; // matriz de 4x4
  
  logic[1:0] i, j;
  initial begin
    // Inicializar la matriz con valores máximos de 2048
    for (i = 0; i < 4; i++) begin
      for (j = 0; j < 4; j++) begin
        matriz[i][j] = 4*i+j;
      end
    end
    
    // Mostrar la matriz
    $display("Matriz:");
    for (i = 0; i < 4; i++) begin
      for (j = 0; j < 4; j++) begin
        $display("%d, ", matriz[i][j]);
      end
    end
	 $finish;
  end
endmodule
