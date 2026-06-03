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
    global.input_mode = "none";
    global.puzzle_attempts = 0;
    global.dialogue_text = "";
    global.dialogue_timer = 0;

    audio_stop_sound(global.menu_music);
	room_goto(rm_lab_01);
}
