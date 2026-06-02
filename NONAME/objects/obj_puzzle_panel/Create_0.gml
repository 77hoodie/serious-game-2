label = "Painel de Funcao";

interact = function() {
    if (global.lab_01_puzzle_solved) {
        global.dialogue_text = "Painel: protocolo ja resolvido. f(1,2) = 5. A porta verde esta liberada.";
        global.dialogue_timer = -1;
    } else {
        global.input_mode = "puzzle_lab_01";
        global.dialogue_text = "PAINEL - Funcoes de varias variaveis\n\nf(x,y) = x^2 + y^2\nQuanto vale f(1,2)?\n\n1) 3\n2) 5\n3) 8\n\nPressione 1, 2 ou 3.";
        global.dialogue_timer = -1;
    }
};
