press_timer += 1;
if (title_alpha < 1) title_alpha += 0.02;

if (keyboard_check_pressed(vk_enter)) {
    room_goto(rm_difficulty);
}
