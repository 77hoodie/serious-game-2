// UI geral do prototipo.
// A HUD da sala aparece durante exploracao.
// Dialogos e quadro usam uma camada escura por cima da room para destacar a interface.

if (room != rm_lab_01) {
    exit;
}

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// HUD simples da sala. Quando houver dialogo/quadro, ela fica escurecida junto com o fundo.
draw_set_color(c_white);
draw_text(24, 18, "Midnight School - Prototipo");
draw_text(24, 42, "Objetivo: converse com o tutor, resolva o quadro, abra a porta e enfrente o inimigo.");
draw_text(24, 66, "Controles: WASD move | E interage | ENTER fecha/avanca dialogos");
draw_text(24, 90, "Modo atual: " + (global.hard_mode ? "DIFICIL" : "APRENDIZADO"));

if (global.lab_01_puzzle_solved) {
    draw_set_color(c_lime);
    draw_text(24, 118, "Quadro resolvido: a porta esta aberta.");
} else {
    draw_set_color(c_yellow);
    draw_text(24, 118, "Quadro pendente: use E no quadro quando terminar a conversa.");
}

if (global.dialogue_text != "") {
    // Escurece a room inteira antes de desenhar dialogos/quadro.
    // Isso evita que objetos da sala, como a porta, aparecam por cima dos retratos.
    var overlay_alpha = (global.input_mode == "puzzle_lab_01") ? 0.88 : 0.78;
    draw_set_alpha(overlay_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);

    // O quadro usa uma caixa propria, centralizada, para nao cortar alternativas.
    if (global.input_mode == "puzzle_lab_01") {
        var panel_x1 = 150;
        var panel_y1 = 90;
        var panel_x2 = room_width - 150;
        var panel_y2 = room_height - 90;

        draw_set_alpha(0.97);
        draw_set_color(c_black);
        draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y2, false);
        draw_set_alpha(1);

        draw_set_color(c_white);
        draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y2, true);

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
        draw_text_transformed(panel_x1 + 34, panel_y1 + 26, "Quadro", 1.25, 1.25, 0);

        draw_set_alpha(0.78);
        draw_line(panel_x1 + 34, panel_y1 + 66, panel_x2 - 34, panel_y1 + 66);
        draw_set_alpha(1);

        draw_text_ext(panel_x1 + 34, panel_y1 + 92, global.dialogue_text, 30, panel_x2 - panel_x1 - 68);

        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_alpha(0.72);
        draw_text(panel_x2 - 34, panel_y2 - 24, "1, 2 ou 3 para responder   |   ENTER/ESC para sair");
        draw_set_alpha(1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    } else {
        // Caixa de dialogo no estilo JRPG/Persona, com retrato do personagem ativo.
        var raw_text = global.dialogue_text;
        var speaker = "";
        var body_text = raw_text;

        if (string_pos("Tutor:", raw_text) == 1) {
            speaker = "Tutor";
            body_text = string_copy(raw_text, 8, string_length(raw_text));
        } else if (string_pos("Eu:", raw_text) == 1) {
            speaker = "Eu";
            body_text = string_copy(raw_text, 5, string_length(raw_text));
        }

        var box_x1 = 76;
        var box_y1 = room_height - 220;
        var box_x2 = room_width - 76;
        var box_y2 = room_height - 30;

        var text_x = box_x1 + 30;
        var text_w = box_x2 - box_x1 - 60;

        // Retratos ficam fora da box, sobre o fundo escurecido.
        // Assim eles nao competem visualmente com os objetos da room.
        if (speaker == "Eu") {
            draw_sprite_ext(sprite_player_dialogue, 0, 90, room_height - 498, 0.58, 0.58, 0, c_white, 1);
            text_x = box_x1 + 310;
            text_w = box_x2 - text_x - 35;
        } else if (speaker == "Tutor") {
            draw_sprite_ext(sprite_tutor_dialogue, 0, room_width - 332, room_height - 498, 0.58, 0.58, 0, c_white, 1);
            text_x = box_x1 + 30;
            text_w = box_x2 - box_x1 - 360;
        }

        draw_set_alpha(0.96);
        draw_set_color(c_black);
        draw_roundrect(box_x1, box_y1, box_x2, box_y2, false);
        draw_set_alpha(1);

        draw_set_color(c_white);
        draw_roundrect(box_x1, box_y1, box_x2, box_y2, true);

        if (speaker != "") {
            draw_set_color(c_white);
            draw_text_transformed(text_x, box_y1 + 18, speaker, 1.08, 1.08, 0);
            draw_set_alpha(0.55);
            draw_line(text_x, box_y1 + 48, text_x + min(text_w, 300), box_y1 + 48);
            draw_set_alpha(1);
            draw_text_ext(text_x, box_y1 + 64, body_text, 24, text_w);
        } else {
            draw_set_color(c_white);
            draw_text_ext(text_x, box_y1 + 24, body_text, 24, text_w);
        }

        // Qualquer dialogo fora do quadro pode ser fechado ou avancado com ENTER.
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_alpha(0.68);
        draw_text(box_x2 - 18, box_y2 - 14, "ENTER");
        draw_set_alpha(1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
