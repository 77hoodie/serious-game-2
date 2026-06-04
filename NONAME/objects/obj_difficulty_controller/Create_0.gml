// Tela de selecao de dificuldade.
// A escolha fica em variaveis globais para ser usada por puzzles e combates.

if (!variable_global_exists("booly_unlocked")) global.booly_unlocked = false;
if (!variable_global_exists("booly_reward_apples")) global.booly_reward_apples = false;
if (!variable_global_exists("item_apples")) global.item_apples = 0;

if (!variable_global_exists("menu_music")) global.menu_music = noone;
if (global.menu_music == noone) {
    global.menu_music = audio_play_sound(snd_menu_theme, 10, true);
}

selected_option = 0; // 0 = Aprendizado, 1 = Dificil, 2 = Booly/???
options_count = 3;
locked_notice = "";
locked_notice_timer = 0;
