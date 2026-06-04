// UI geral do prototipo.
// A HUD da sala aparece durante exploracao.
// Dialogos, menu e quadro usam uma camada escura por cima da room.

if (room != rm_lab_01 && room != rm_lab_02 && room != rm_lab_03) {
    exit;
}

var is_lab_02 = (room == rm_lab_02);
var is_lab_03 = (room == rm_lab_03);
var solved = is_lab_03 ? global.lab_03_puzzle_solved : (is_lab_02 ? global.lab_02_puzzle_solved : global.lab_01_puzzle_solved);
var room_title = is_lab_03 ? "Sala do Cartografo" : (is_lab_02 ? "Sala das Variacoes" : "Sala inicial");
var board_label = is_lab_03 ? "Mesa pendente: vetor gradiente." : (is_lab_02 ? "Quadro pendente: derivada parcial." : "Quadro pendente: funcao de varias variaveis.");

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// HUD simples da sala. Quando houver dialogo/quadro/menu, ela fica escurecida junto com o fundo.
draw_set_color(c_white);
draw_text(24, 18, "Midnight School - " + room_title);
draw_text(24, 42, "Objetivo: fale com o tutor, resolva o quadro e avance pela porta.");
draw_text(24, 66, "Controles: WASD move | E interage | M menu | ENTER fecha/avanca dialogos");
draw_text(24, 90, "Modo atual: " + (global.hard_mode ? "DIFICIL" : "APRENDIZADO"));

if (solved) {
    draw_set_color(c_lime);
    draw_text(24, 118, "Quadro resolvido: a porta esta aberta.");
} else {
    draw_set_color(c_yellow);
    draw_text(24, 118, board_label);
}

// Visualizacao opcional dos retangulos de colisao.
if (variable_global_exists("debug_collisions") && global.debug_collisions) {
    draw_set_alpha(0.28);
    draw_set_color(c_red);
    var rects = is_lab_03 ? global.lab_03_collision_rects : (is_lab_02 ? global.lab_02_collision_rects : global.lab_01_collision_rects);
    for (var i = 0; i < array_length(rects); i += 1) {
        var r = rects[i];
        draw_rectangle(r[0], r[1], r[2], r[3], false);
    }
    draw_set_alpha(1);
}

// Menu do jogador.
if (global.input_mode == "player_menu") {
    draw_set_alpha(0.86);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);

    var mx1 = 150;
    var my1 = 86;
    var mx2 = room_width - 150;
    var my2 = room_height - 86;

    draw_set_alpha(0.97);
    draw_set_color(c_black);
    draw_roundrect(mx1, my1, mx2, my2, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(mx1, my1, mx2, my2, true);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text_transformed(mx1 + 36, my1 + 28, "Menu", 1.35, 1.35, 0);

    var tab_items = (global.menu_tab == 0);
    draw_set_color(tab_items ? c_black : c_white);
    if (tab_items) {
        draw_set_color(c_white);
        draw_rectangle(mx1 + 36, my1 + 76, mx1 + 176, my1 + 110, false);
        draw_set_color(c_black);
    }
    draw_text(mx1 + 54, my1 + 84, "Itens");

    if (!tab_items) {
        draw_set_color(c_white);
        draw_rectangle(mx1 + 190, my1 + 76, mx1 + 390, my1 + 110, false);
        draw_set_color(c_black);
    } else {
        draw_set_color(c_white);
    }
    draw_text(mx1 + 210, my1 + 84, "Caderno");

    draw_set_color(c_white);
    draw_set_alpha(0.55);
    draw_line(mx1 + 36, my1 + 128, mx2 - 36, my1 + 128);
    draw_set_alpha(1);

    if (tab_items) {
        draw_text_transformed(mx1 + 44, my1 + 156, "Mochila", 1.14, 1.14, 0);
        draw_text(mx1 + 58, my1 + 208, "Vida maxima: " + string(global.player_max_hp) + " HP");
        draw_text(mx1 + 58, my1 + 236, "Barras de cereal: " + string(global.item_cereal_bars));
        draw_set_alpha(0.72);
        draw_text_ext(mx1 + 58, my1 + 280, "As barras de cereal podem ser usadas em batalha para recuperar HP. Ao passar para uma nova sala importante, sua vida maxima aumenta um pouco.", 26, mx2 - mx1 - 116);
        draw_set_alpha(1);
    } else {
        draw_text_transformed(mx1 + 44, my1 + 156, "Caderno de anotacoes", 1.14, 1.14, 0);
        var page_count = array_length(global.notebook_pages);
        if (page_count <= 0) {
            draw_set_alpha(0.72);
            draw_text_ext(mx1 + 58, my1 + 208, "Ainda nao ha paginas no caderno. Elas aparecem depois das batalhas vencidas.", 26, mx2 - mx1 - 116);
            draw_set_alpha(1);
        } else {
            global.notebook_page_index = clamp(global.notebook_page_index, 0, page_count - 1);
            var page = global.notebook_pages[global.notebook_page_index];
            draw_text(mx1 + 58, my1 + 204, "Pagina " + string(global.notebook_page_index + 1) + "/" + string(page_count));
            draw_text_transformed(mx1 + 58, my1 + 238, page.title, 1.08, 1.08, 0);
            draw_set_alpha(0.9);
            draw_text_ext(mx1 + 58, my1 + 288, page.body, 27, mx2 - mx1 - 116);
            draw_set_alpha(1);
        }
    }

    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_alpha(0.68);
    draw_text(mx2 - 28, my2 - 22, "A/D alterna abas | W/S troca pagina | M ou ESC fecha");
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    exit;
}

if (global.dialogue_text != "") {
    // Escurece a room inteira antes de desenhar dialogos/quadro.
    var overlay_alpha = (global.input_mode == "puzzle_lab_01" || global.input_mode == "puzzle_lab_02" || global.input_mode == "puzzle_lab_03") ? 0.88 : 0.78;
    draw_set_alpha(overlay_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);

    // O quadro usa uma caixa propria, centralizada, para nao cortar alternativas.
    if (global.input_mode == "puzzle_lab_01" || global.input_mode == "puzzle_lab_02" || global.input_mode == "puzzle_lab_03") {
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
        draw_text_transformed(panel_x1 + 34, panel_y1 + 26, is_lab_03 ? "Mesa cartografica - Vetor gradiente" : (is_lab_02 ? "Quadro da sala - Derivadas parciais" : "Quadro da sala"), 1.25, 1.25, 0);

        draw_set_alpha(0.78);
        draw_line(panel_x1 + 34, panel_y1 + 66, panel_x2 - 34, panel_y1 + 66);
        draw_set_alpha(1);

        draw_text_ext(panel_x1 + 34, panel_y1 + 92, global.dialogue_text, 26, panel_x2 - panel_x1 - 68);

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
            draw_text_transformed(text_x, box_y1 + 18, speaker, 1.08, 1.08, 0);
            draw_set_alpha(0.55);
            draw_line(text_x, box_y1 + 48, text_x + min(text_w, 300), box_y1 + 48);
            draw_set_alpha(1);
            draw_text_ext(text_x, box_y1 + 64, body_text, 24, text_w);
        } else {
            draw_text_ext(text_x, box_y1 + 24, body_text, 24, text_w);
        }

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
