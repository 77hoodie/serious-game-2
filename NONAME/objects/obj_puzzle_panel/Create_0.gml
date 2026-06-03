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

interact = function() {
    if (room == rm_lab_02) {
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
