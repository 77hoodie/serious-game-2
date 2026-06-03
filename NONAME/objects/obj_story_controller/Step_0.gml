press_timer += 1;

if (fade_alpha > 0) {
    fade_alpha = max(0, fade_alpha - 0.025);
}

if (page_alpha < 1) {
    page_alpha = min(1, page_alpha + 0.035);
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    if (page_alpha < 0.95) {
        page_alpha = 1;
    } else {
        story_page += 1;
        if (story_page >= array_length(story_pages)) {
            room_goto(rm_lab_01);
        } else {
            page_alpha = 0;
        }
    }
}

if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_lab_01);
}
