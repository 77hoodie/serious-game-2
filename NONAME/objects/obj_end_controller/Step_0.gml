if (keyboard_check_pressed(vk_enter)) {
    if (variable_global_exists("battle_music") && global.battle_music != noone) {
        audio_stop_sound(global.battle_music);
        global.battle_music = noone;
    }
    room_goto(rm_difficulty);
}
