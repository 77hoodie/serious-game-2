// UI geral do prototipo.
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (room == rm_lab_01) {
    draw_set_color(c_white);
    draw_text(24, 18, "PROTOTIPO: Escape Room + RPG educativo");
    draw_text(24, 42, "Objetivo: interaja com o painel, aprenda a funcao f(x,y), abra a porta e enfrente o vilao.");
    draw_text(24, 66, "Controles: WASD move | E interage | H alterna modo aprendizado/dificil");
    draw_text(24, 90, "Modo atual: " + (global.hard_mode ? "DIFICIL" : "APRENDIZADO"));

    if (global.lab_01_puzzle_solved) {
        draw_set_color(c_lime);
        draw_text(24, 118, "Painel resolvido: a porta esta aberta.");
    } else {
        draw_set_color(c_yellow);
        draw_text(24, 118, "Painel pendente: use E no painel azul.");
    }
}

if (global.dialogue_text != "") {
    var box_x1 = 24;
    var box_y1 = room_height - 150;
    var box_x2 = room_width - 24;
    var box_y2 = room_height - 24;

    draw_set_alpha(0.82);
    draw_set_color(c_black);
    draw_roundrect(box_x1, box_y1, box_x2, box_y2, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_text_ext(box_x1 + 18, box_y1 + 16, global.dialogue_text, 24, box_x2 - box_x1 - 36);
}
