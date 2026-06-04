var move_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var move_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));

if (move_up) selected_option = (selected_option + options_count - 1) mod options_count;
if (move_down) selected_option = (selected_option + 1) mod options_count;

if (locked_notice_timer > 0) locked_notice_timer -= 1;

if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_title);
}

reset_main_game = function() {
    global.lab_01_puzzle_solved = false;
    global.lab_02_puzzle_solved = false;
    global.lab_03_puzzle_solved = false;
    global.lab_04_puzzle_solved = false;
    global.lab_04_puzzle_stage = 0;
    global.lab_01_intro_done = false;
    global.lab_02_intro_done = false;
    global.lab_03_intro_done = false;
    global.lab_04_intro_done = false;
    global.lab_booly_intro_done = false;
    global.input_mode = "none";
    global.puzzle_attempts = 0;
    global.puzzle_attempts_lab_02 = 0;
    global.puzzle_attempts_lab_03 = 0;
    global.puzzle_attempts_lab_04 = 0;
    global.dialogue_text = "";
    global.dialogue_timer = 0;

    global.player_max_hp = 30;
    global.player_hp = global.player_max_hp;
    global.hp_bonus_after_monitor = false;
    global.hp_bonus_after_aluna = false;
    global.hp_bonus_after_cartografo = false;
    global.hp_bonus_after_isiaha = false;
    global.item_cereal_bars = 0;
    global.item_apples = 0;
    global.notebook_pages = [];
    global.notebook_page_index = 0;
    global.notebook_monitor_sem_rosto = false;
    global.notebook_aluna_janela = false;
    global.notebook_cartografo = false;
    global.notebook_isiaha = false;
    global.booly_completed = false;
    global.reward_monitor_items = false;
    global.booly_reward_apples = false;
};

stop_menu_music = function() {
    if (variable_global_exists("menu_music") && global.menu_music != noone) {
        audio_stop_sound(global.menu_music);
        global.menu_music = noone;
    }
};

if (keyboard_check_pressed(vk_enter)) {
    if (selected_option == 0) {
        global.difficulty_mode = "learning";
        global.hard_mode = false;
        reset_main_game();
        stop_menu_music();
        room_goto(rm_story);
    } else if (selected_option == 1) {
        global.difficulty_mode = "hard";
        global.hard_mode = true;
        reset_main_game();
        stop_menu_music();
        room_goto(rm_story);
    } else {
        if (!global.booly_unlocked) {
            locked_notice = "Termine o jogo no Modo Dificil para liberar o Modo Booly.";
            locked_notice_timer = 150;
        } else {
            global.difficulty_mode = "booly";
            global.hard_mode = true;
            global.input_mode = "none";
            global.dialogue_text = "";
            global.dialogue_timer = 0;
            global.lab_booly_intro_done = false;
            global.current_battle = "booly";
            global.player_hp = global.player_max_hp;
            if (global.item_apples < 3) global.item_apples = 3;
            stop_menu_music();
            room_goto(rm_lab_booly);
        }
    }
}
