draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text_transformed(room_width * 0.5, 76, "Escolha a dificuldade", 1.5, 1.5, 0);

draw_set_alpha(0.72);
draw_text(room_width * 0.5, 132, "Use W/S ou as setas. Pressione ENTER para confirmar.");
draw_set_alpha(1);

var card_w = 900;
var card_h = 165;
var x1 = (room_width - card_w) * 0.5;
var y1 = 225;
var gap = 36;

for (var i = 0; i < options_count; i += 1) {
    var cy1 = y1 + i * (card_h + gap);
    var cy2 = cy1 + card_h;

    if (selected_option == i) {
        draw_set_color(c_white);
        draw_rectangle(x1 - 4, cy1 - 4, x1 + card_w + 4, cy2 + 4, false);
        draw_set_color(c_black);
        draw_rectangle(x1, cy1, x1 + card_w, cy2, false);
    } else {
        draw_set_color(make_color_rgb(24, 24, 24));
        draw_rectangle(x1, cy1, x1 + card_w, cy2, false);
        draw_set_color(make_color_rgb(95, 95, 95));
        draw_rectangle(x1, cy1, x1 + card_w, cy2, true);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    if (i == 0) {
        draw_text_transformed(x1 + 34, cy1 + 24, "Modo Aprendizado", 1.15, 1.15, 0);
        draw_set_alpha(0.78);
        draw_text_ext(x1 + 34, cy1 + 68,
            "Para quem quer aprender ou revisar os conceitos matematicos durante a partida. Erros liberam dicas progressivas, explicacoes do tutor e novas tentativas sem punicao pesada.",
            24, card_w - 68);
        draw_set_alpha(1);
    } else {
        draw_text_transformed(x1 + 34, cy1 + 24, "Modo Dificil", 1.15, 1.15, 0);
        draw_set_alpha(0.78);
        draw_text_ext(x1 + 34, cy1 + 68,
            "Para jogadores que ja dominam melhor o conteudo. As dicas sao menos centrais e erros em combate podem causar perda de HP, mantendo o foco em desafio e precisao.",
            24, card_w - 68);
        draw_set_alpha(1);
    }
}

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_alpha(0.65);
draw_text(room_width * 0.5, room_height - 34, "ESC volta para a tela inicial");
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
