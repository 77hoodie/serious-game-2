if (keyboard_check_pressed(ord("H"))) {
    global.hard_mode = !global.hard_mode;
    if (global.hard_mode) {
        global.dialogue_text = "Modo dificil ligado: erros no combate podem causar dano.";
    } else {
        global.dialogue_text = "Modo aprendizado ligado: erros viram dicas e explicacoes.";
    }
    global.dialogue_timer = 180;
}

if (global.dialogue_timer > 0) {
    global.dialogue_timer -= 1;
    if (global.dialogue_timer <= 0) global.dialogue_text = "";
}
