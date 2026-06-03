draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Titulo principal.
draw_set_alpha(title_alpha);
draw_set_color(c_white);
draw_text_transformed(room_width * 0.5, room_height * 0.36, "Midnight School", 3.2, 3.2, 0);

draw_set_alpha(0.75 * title_alpha);
draw_text(room_width * 0.5, room_height * 0.47, "Serious game de calculo multivariavel");

// Aviso de entrada.
var blink = 0.45 + 0.55 * abs(sin(press_timer / 28));
draw_set_alpha(blink * title_alpha);
draw_text(room_width * 0.5, room_height * 0.66, "Pressione ENTER");
draw_set_alpha(0.65 * blink * title_alpha);
draw_text(room_width * 0.5, room_height * 0.71, "para escolher a dificuldade");

draw_set_alpha(0.42 * title_alpha);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(40, room_height - 34, "Prototipo em desenvolvimento");

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
