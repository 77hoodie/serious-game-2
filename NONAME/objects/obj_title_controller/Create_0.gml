// Tela inicial do jogo.
// Mantem apenas o fluxo de entrada para a selecao de dificuldade.

if (!variable_global_exists("menu_music")) {
    global.menu_music = noone;
}

if (global.menu_music == noone) {
    global.menu_music = audio_play_sound(snd_menu_theme, 10, true);
}

title_alpha = 0;
press_timer = 0;
