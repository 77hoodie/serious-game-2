// UI geral do prototipo.
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (room == rm_lab_01) {
    draw_set_color(c_white);
    draw_text(24, 18, "Midnight School - Prototipo");
    draw_text(24, 42, "Objetivo: converse com o tutor, resolva o quadro, abra a porta e enfrente o inimigo.");
    draw_text(24, 66, "Controles: WASD move | E interage | ENTER avanca dialogos");
    draw_text(24, 90, "Modo atual: " + (global.hard_mode ? "DIFICIL" : "APRENDIZADO"));

    if (global.lab_01_puzzle_solved) {
        draw_set_color(c_lime);
        draw_text(24, 118, "Quadro resolvido: a porta esta aberta.");
    } else {
        draw_set_color(c_yellow);
        draw_text(24, 118, "Quadro pendente: use E no quadro quando terminar a conversa.");
    }
}

if (global.dialogue_text != "") {
    var box_x1 = 24;
    var box_y1 = room_height - 158;
    var box_x2 = room_width - 24;
    var box_y2 = room_height - 24;

    draw_set_alpha(0.86);
    draw_set_color(c_black);
    draw_roundrect(box_x1, box_y1, box_x2, box_y2, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_text_ext(box_x1 + 18, box_y1 + 16, global.dialogue_text, 24, box_x2 - box_x1 - 36);

    if (global.input_mode == "lab_intro") {
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_alpha(0.65);
        draw_text(box_x2 - 18, box_y2 - 14, "ENTER");
        draw_set_alpha(1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}
