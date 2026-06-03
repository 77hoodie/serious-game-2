label = "Quadro de Funcao";

interact = function() {
    if (global.lab_01_puzzle_solved) {
        global.dialogue_text = "Quadro: resposta ja escrita. f(1,2) = 5. A porta verde esta liberada.";
        global.dialogue_timer = -1;
    } else {
        global.input_mode = "puzzle_lab_01";
        global.dialogue_text = "QUADRO - Funcoes de varias variaveis\n\nAnotacoes no canto:\n- Uma funcao f(x,y) recebe dois valores.\n- O primeiro valor do par e x.\n- O segundo valor do par e y.\n- Substitua antes de calcular.\n\nQuestao:\nf(x,y) = x^2 + y^2\nQuanto vale f(1,2)?\n\n1) 3\n2) 5\n3) 8";
        global.dialogue_timer = -1;
    }
};
