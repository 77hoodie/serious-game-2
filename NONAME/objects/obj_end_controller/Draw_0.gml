draw_set_color(make_color_rgb(15, 35, 30));
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext(90, 110, message, 28, room_width - 180);
draw_set_color(c_yellow);
draw_text(90, room_height - 110, "ENTER para voltar a selecao de dificuldade");
