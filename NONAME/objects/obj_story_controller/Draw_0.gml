draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_set_alpha(0.72);
draw_set_color(c_white);
draw_text(room_width * 0.5, 70, "Midnight School");

draw_set_alpha(page_alpha);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var box_w = 820;
var tx = (room_width - box_w) * 0.5;
var ty = 230;
draw_text_ext(tx, ty, story_pages[story_page], 30, box_w);

draw_set_halign(fa_center);
var blink = 0.45 + 0.55 * abs(sin(press_timer / 26));
draw_set_alpha(blink * page_alpha * 0.75);
draw_text(room_width * 0.5, room_height - 96, "ENTER para continuar");

draw_set_alpha(page_alpha * 0.35);
draw_text(room_width * 0.5, room_height - 58, "ESC pula a introducao");

if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
}

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
