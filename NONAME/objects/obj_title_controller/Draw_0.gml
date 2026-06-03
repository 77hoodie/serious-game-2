// Tela inicial com a escola ao fundo.
// A imagem do menu fica como cenario; o texto e desenhado por cima.
var bg_w = sprite_get_width(sprite_school_menu);
var bg_h = sprite_get_height(sprite_school_menu);
var sx = room_width / bg_w;
var sy = room_height / bg_h;

draw_sprite_ext(sprite_school_menu, 0, 0, 0, sx, sy, 0, c_white, 1);

// Escurece levemente para manter o titulo legivel.
draw_set_alpha(0.46);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

// Vinheta simples.
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, 120, false);
draw_rectangle(0, room_height - 150, room_width, room_height, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Titulo principal.
draw_set_alpha(title_alpha);
draw_set_color(c_white);
draw_text_transformed(room_width * 0.5, room_height * 0.35, "Midnight School", 3.2, 3.2, 0);

draw_set_alpha(0.75 * title_alpha);
draw_text(room_width * 0.5, room_height * 0.46, "Serious game de calculo multivariavel");

// Aviso de entrada.
var blink = 0.45 + 0.55 * abs(sin(press_timer / 28));
draw_set_alpha(blink * title_alpha);
draw_text(room_width * 0.5, room_height * 0.67, "Pressione ENTER");
draw_set_alpha(0.65 * blink * title_alpha);
draw_text(room_width * 0.5, room_height * 0.72, "para escolher a dificuldade");

draw_set_alpha(0.48 * title_alpha);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(40, room_height - 34, "Prototipo em desenvolvimento");

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
