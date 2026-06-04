draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text_transformed(room_width * 0.5, 50, "Escolha a dificuldade", 1.5, 1.5, 0);

draw_set_alpha(0.72);
draw_text(room_width * 0.5, 105, "Use W/S ou as setas. Pressione ENTER para confirmar.");
draw_set_alpha(1);

var card_w = 900;
var card_h = 128;
var x1 = (room_width - card_w) * 0.5;
var y1 = 162;
var gap = 22;

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
        draw_text_transformed(x1 + 34, cy1 + 18, "Modo Aprendizado", 1.12, 1.12, 0);
        draw_set_alpha(0.78);
        draw_text_ext(x1 + 34, cy1 + 56,
            "Para aprender ou revisar os conceitos durante a partida. Erros liberam dicas progressivas, explicacoes do tutor e novas tentativas sem punicao pesada.",
            23, card_w - 68);
        draw_set_alpha(1);
    } else if (i == 1) {
        draw_text_transformed(x1 + 34, cy1 + 18, "Modo Dificil", 1.12, 1.12, 0);
        draw_set_alpha(0.78);
        draw_text_ext(x1 + 34, cy1 + 56,
            "Para jogadores que ja dominam melhor o conteudo. Dicas sao limitadas, inimigos causam mais dano e as perguntas exigem mais precisao.",
            23, card_w - 68);
        draw_set_alpha(1);
    } else {
        if (global.booly_unlocked) {
            draw_text_transformed(x1 + 34, cy1 + 18, "Modo Booly", 1.12, 1.12, 0);
            draw_set_alpha(0.78);
            draw_text_ext(x1 + 34, cy1 + 56,
                "Desafio secreto liberado apos terminar o jogo no Modo Dificil. Booly mistura todos os assuntos e testa o caderno inteiro.",
                23, card_w - 68);
            draw_set_alpha(1);
        } else {
            draw_text_transformed(x1 + 34, cy1 + 18, "???", 1.12, 1.12, 0);
            draw_set_alpha(0.62);
            draw_text_ext(x1 + 34, cy1 + 56,
                "Termine o jogo no Modo Dificil para liberar este desafio.",
                23, card_w - 68);
            draw_set_alpha(1);
        }
    }
}

if (locked_notice_timer > 0) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_yellow);
    draw_text(room_width * 0.5, room_height - 92, locked_notice);
}

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_alpha(0.65);
draw_set_color(c_white);
draw_text(room_width * 0.5, room_height - 34, "ESC volta para a tela inicial");
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
