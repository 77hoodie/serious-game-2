var move_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var move_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));

if (move_up) selected_option = (selected_option + options_count - 1) mod options_count;
if (move_down) selected_option = (selected_option + 1) mod options_count;

if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_title);
}

if (keyboard_check_pressed(vk_enter)) {
    if (selected_option == 0) {
        global.difficulty_mode = "learning";
        global.hard_mode = false;
    } else {
        global.difficulty_mode = "hard";
        global.hard_mode = true;
    }

    global.lab_01_puzzle_solved = false;
    global.lab_02_puzzle_solved = false;
    global.lab_03_puzzle_solved = false;
global.lab_04_puzzle_solved = false;
global.lab_04_puzzle_stage = 0;
    global.lab_01_intro_done = false;
    global.lab_02_intro_done = false;
    global.lab_03_intro_done = false;
global.lab_04_intro_done = false;
    global.input_mode = "none";
    global.puzzle_attempts = 0;
    global.puzzle_attempts_lab_02 = 0;
    global.puzzle_attempts_lab_03 = 0;
global.puzzle_attempts_lab_04 = 0;
    global.dialogue_text = "";
    global.dialogue_timer = 0;

    // Reinicia progresso de uma nova partida.
    global.player_max_hp = 30;
    global.player_hp = global.player_max_hp;
    global.hp_bonus_after_monitor = false;
    global.hp_bonus_after_aluna = false;
    global.hp_bonus_after_cartografo = false;
global.hp_bonus_after_isiaha = false;
    global.item_cereal_bars = 0;
    global.notebook_pages = [];
    global.notebook_page_index = 0;
    global.notebook_monitor_sem_rosto = false;
    global.notebook_aluna_janela = false;
    global.notebook_cartografo = false;
global.notebook_isiaha = false;
    global.reward_monitor_items = false;

    if (variable_global_exists("menu_music") && global.menu_music != noone) {
        audio_stop_sound(global.menu_music);
        global.menu_music = noone;
    }
    room_goto(rm_story);
}
