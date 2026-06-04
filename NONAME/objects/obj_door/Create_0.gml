interact = function() {
    if (room == rm_lab_03) {
        if (global.lab_03_puzzle_solved) {
            global.input_mode = "none";
            global.dialogue_text = "A passagem no mapa se abre como se alguem tivesse desenhado uma rota nova.";
            global.dialogue_timer = 60;
            global.last_room_before_battle = room;
            global.current_battle = "cartografo";
            room_goto(rm_battle_03);
        } else {
            global.dialogue_text = "Passagem bloqueada. A mesa cartografica ainda espera o vetor gradiente.";
            global.dialogue_timer = -1;
        }
    } else if (room == rm_lab_02) {
        if (global.lab_02_puzzle_solved) {
            global.input_mode = "none";
            global.dialogue_text = "Ao tocar na porta, a luz da janela apaga por um instante.";
            global.dialogue_timer = 60;
            global.last_room_before_battle = room;
            global.current_battle = "aluna";
            room_goto(rm_battle_02);
        } else {
            global.dialogue_text = "Porta trancada. O quadro ainda espera uma derivada parcial.";
            global.dialogue_timer = -1;
        }
    } else {
        if (global.lab_01_puzzle_solved) {
            global.input_mode = "none";
            global.dialogue_text = "Voce atravessou a porta. Alguem esta esperando do outro lado.";
            global.dialogue_timer = 60;
            global.last_room_before_battle = room;
            global.current_battle = "monitor";
            room_goto(rm_battle_01);
        } else {
            global.dialogue_text = "Porta trancada. Resolva o quadro primeiro. O objetivo e aprender antes de avancar.";
            global.dialogue_timer = -1;
        }
    }
};
