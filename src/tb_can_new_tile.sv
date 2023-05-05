`timescale 1ns / 1ps

module tb_can_new_tile();
    logic [11:0] board_in [3:0][3:0];
    logic result;

    // Instanciar el módulo can_new_tile
    can_new_tile can_new_tile_inst(
        .board_in(board_in),
        .result(result)
    );

    initial begin
        // Caso de prueba 1: Matriz con espacio disponible
        board_in = '{
            '{4, 16, 8, 8},
            '{8, 0, 64, 4},
            '{4, 32, 0, 16},
            '{2, 0, 16, 8}
        };
        #10;
        assert(result == 1) else $error("Caso de prueba 1: Error, se esperaba result = 1");

        // Caso de prueba 2: Matriz sin espacio disponible
        board_in = '{
                '{4, 16, 8, 8},
                '{8, 128, 64, 4},
                '{4, 32, 8, 16},
                '{2, 4, 16, 8}
        }; // Sin espacio disponible
        #10;
        assert(result == 0) else $error("Caso de prueba 2: Error, se esperaba result = 0");

        // Finalizar la simulacion
        $finish;
    end
endmodule
