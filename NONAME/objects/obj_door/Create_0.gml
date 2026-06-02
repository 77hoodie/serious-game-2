interact = function() {
    if (global.lab_01_puzzle_solved) {
        global.input_mode = "none";
        global.dialogue_text = "Voce atravessou a porta. Um vilao apareceu!";
        global.dialogue_timer = 60;
        room_goto(rm_battle_01);
    } else {
        global.dialogue_text = "Porta trancada. Resolva o painel primeiro. O objetivo e aprender antes de avancar.";
        global.dialogue_timer = 160;
    }
};
