// Atualiza a caixa de dialogo temporaria.
// A dificuldade agora e definida no menu inicial.

if (global.dialogue_timer > 0) {
    global.dialogue_timer -= 1;
    if (global.dialogue_timer <= 0) global.dialogue_text = "";
}
