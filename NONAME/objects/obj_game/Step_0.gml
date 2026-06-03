// Atualiza caixa de dialogo e cutscenes simples.
// ENTER fecha dialogos livres e avanca cutscenes.
// A dificuldade e definida no menu inicial.

// Dialogos livres: mensagens do tutor, porta, acertos e avisos ficam paradas
// ate o jogador apertar ENTER. Isso evita andar pela room com o fundo escuro aberto.
if (global.input_mode == "none" && global.dialogue_text != "") {
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        global.dialogue_text = "";
        global.dialogue_timer = 0;
    }
}

if (global.input_mode == "lab_intro") {
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        global.lab_intro_page += 1;

        if (global.lab_intro_page >= array_length(global.lab_intro_lines)) {
            global.lab_01_intro_done = true;
            global.input_mode = "none";
            global.dialogue_text = "";
            global.dialogue_timer = 0;
        } else {
            global.dialogue_text = global.lab_intro_lines[global.lab_intro_page];
            global.dialogue_timer = -1;
        }
    }
}

if (global.dialogue_timer > 0) {
    global.dialogue_timer -= 1;
    if (global.dialogue_timer <= 0) global.dialogue_text = "";
}
