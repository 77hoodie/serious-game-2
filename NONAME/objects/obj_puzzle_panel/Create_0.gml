label = "Quadro";

lab_01_board_text = function() {
    return "QUADRO - Funcoes de varias variaveis\n\nAnotacoes no canto:\n- Uma funcao f(x,y) recebe dois valores.\n- O primeiro valor do par e x.\n- O segundo valor do par e y.\n- Substitua antes de calcular.\n\nQuestao:\nf(x,y) = x^2 + y^2\nQuanto vale f(1,2)?\n\n1) 3\n2) 5\n3) 8";
};

lab_02_board_text = function() {
    if (global.hard_mode) {
        return "QUADRO - Derivadas parciais\n\nAnotacoes no canto:\n- Para derivar em relacao a y, trate x como constante.\n- O termo x^2*y muda com y, mas x^2 fica como coeficiente.\n- O termo 4y^2 vira 8y.\n\nQuestao:\nf(x,y) = x^2*y + 4y^2\nQual e df/dy no ponto (2,1)?\n\n1) 8\n2) 10\n3) 12";
    }

    return "QUADRO - Derivadas parciais\n\nAnotacoes no canto:\n- Em uma derivada parcial, so uma variavel muda.\n- Para df/dx, trate y como constante.\n- Para df/dy, trate x como constante.\n\nQuestao:\nf(x,y) = x^2 + 3y\nQual e df/dx no ponto (2,1)?\n\n1) 3\n2) 4\n3) 7";
};

lab_03_board_text = function() {
    if (global.hard_mode) {
        return "MESA CARTOGRAFICA - Vetor gradiente\n\nAnotacoes rabiscadas:\n- O gradiente junta duas derivadas parciais.\n- grad f(x,y) = (df/dx, df/dy).\n- A primeira componente aponta a variacao em x.\n- A segunda componente aponta a variacao em y.\n\nQuestao:\nf(x,y) = 2x^2 + xy\nNo ponto (1,2), qual e grad f?\n\n1) (4,2)\n2) (6,1)\n3) (2,6)";
    }

    return "MESA CARTOGRAFICA - Vetor gradiente\n\nAnotacoes rabiscadas:\n- O gradiente mostra a direcao de maior crescimento.\n- Primeiro calcule df/dx.\n- Depois calcule df/dy.\n- Junte os dois resultados em um vetor.\n\nQuestao:\nf(x,y) = x^2 + y^2\nNo ponto (1,2), qual e grad f?\n\n1) (2,4)\n2) (1,2)\n3) (4,2)";
};


lab_04_board_text = function() {
    if (global.lab_04_puzzle_stage <= 0) {
        if (global.hard_mode) {
            return "PEDESTAL - Pontos criticos\n\nAnotacoes gravadas:\n- Um ponto critico aparece quando df/dx = 0 e df/dy = 0.\n- Resolva as duas equacoes ao mesmo tempo.\n\nQuestao:\nf(x,y) = x^2 + 2y^2\nQual e o ponto critico?\n\n1) (0,0)\n2) (1,0)\n3) (0,2)";
        }
        return "PEDESTAL - Pontos criticos\n\nAnotacoes gravadas:\n- Primeiro procure onde a funcao fica parada.\n- Isso acontece quando as derivadas parciais valem zero.\n\nQuestao:\nf(x,y) = x^2 + y^2\nQual e o ponto critico?\n\n1) (0,0)\n2) (1,1)\n3) (2,0)";
    }

    if (global.hard_mode) {
        return "PEDESTAL - Matriz Hessiana\n\nAnotacoes gravadas:\n- Sinais opostos na Hessiana indicam ponto de sela.\n- O ponto pode estar parado e ainda assim nao ser maximo nem minimo.\n\nQuestao:\nH = [ 2   0 ]\n    [ 0  -2 ]\n\nComo classificar o ponto critico?\n\n1) Maximo local\n2) Minimo local\n3) Ponto de sela";
    }

    return "PEDESTAL - Matriz Hessiana\n\nAnotacoes gravadas:\n- A Hessiana observa a curvatura ao redor do ponto.\n- Se a curvatura aponta para cima nas duas direcoes, temos minimo.\n\nQuestao:\nH = [ 2  0 ]\n    [ 0  2 ]\n\nComo classificar o ponto critico?\n\n1) Maximo local\n2) Minimo local\n3) Ponto de sela";
};

interact = function() {
    if (room == rm_lab_04) {
        if (global.lab_04_puzzle_solved) {
            global.dialogue_text = "Pedestal: a classificacao ja foi aceita. A porta esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_04";
            global.dialogue_text = lab_04_board_text();
            global.dialogue_timer = -1;
        }
    } else if (room == rm_lab_03) {
        if (global.lab_03_puzzle_solved) {
            global.dialogue_text = "Mesa: o vetor ja foi marcado no mapa. A passagem esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_03";
            global.dialogue_text = lab_03_board_text();
            global.dialogue_timer = -1;
        }
    } else if (room == rm_lab_02) {
        if (global.lab_02_puzzle_solved) {
            global.dialogue_text = "Quadro: resposta ja escrita. A porta esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_02";
            global.dialogue_text = lab_02_board_text();
            global.dialogue_timer = -1;
        }
    } else {
        if (global.lab_01_puzzle_solved) {
            global.dialogue_text = "Quadro: resposta ja escrita. f(1,2) = 5. A porta verde esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_01";
            global.dialogue_text = lab_01_board_text();
            global.dialogue_timer = -1;
        }
    }
};
