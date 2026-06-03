// Desenho padronizado da batalha.

// Fundo da sala de batalha. A imagem e visual; personagens e HUD sao desenhados por cima.
draw_sprite_stretched(battle_background_sprite, 0, 0, 0, room_width, room_height);

// Leve escurecimento para manter a HUD legivel sem esconder a arte.
draw_set_alpha(0.18);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

// Faixa superior.
draw_set_alpha(0.92);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, 92, false);
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(36, 22, "Midnight School");
draw_set_alpha(0.72);
draw_text(36, 50, battle_number_label + " - " + battle_concept_label + " | Turno " + string(turn_count) + " | " + mode_label);
draw_set_alpha(1);

// Personagens em campo.
draw_sprite_ext(player_battle_sprite, 0, player_battle_x, player_battle_y, player_battle_scale, player_battle_scale, 0, c_white, 1);
draw_sprite_ext(enemy_battle_sprite, 0, enemy_battle_x, enemy_battle_y, enemy_battle_scale, enemy_battle_scale, 0, c_white, 1);

// Painel de status do jogador.
var p_x1 = 54;
var p_y1 = 108;
var p_x2 = 366;
var p_y2 = 178;

draw_set_alpha(0.84);
draw_set_color(c_black);
draw_roundrect(p_x1, p_y1, p_x2, p_y2, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_roundrect(p_x1, p_y1, p_x2, p_y2, true);
draw_text(p_x1 + 18, p_y1 + 12, "Jogador");
draw_text(p_x1 + 18, p_y1 + 38, "HP " + string(player_hp) + "/" + string(max_player_hp));

draw_set_color(make_color_rgb(58, 58, 58));
draw_rectangle(p_x1 + 104, p_y1 + 42, p_x2 - 18, p_y1 + 58, false);
draw_set_color(make_color_rgb(80, 220, 120));
var p_hp_w = (p_x2 - p_x1 - 122) * (player_hp / max_player_hp);
draw_rectangle(p_x1 + 104, p_y1 + 42, p_x1 + 104 + p_hp_w, p_y1 + 58, false);

// Painel de status do inimigo.
var e_x1 = room_width - 430;
var e_y1 = 108;
var e_x2 = room_width - 54;
var e_y2 = 178;

draw_set_alpha(0.84);
draw_set_color(c_black);
draw_roundrect(e_x1, e_y1, e_x2, e_y2, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_roundrect(e_x1, e_y1, e_x2, e_y2, true);
draw_text(e_x1 + 18, e_y1 + 12, enemy_name);
draw_text(e_x1 + 18, e_y1 + 38, "HP " + string(enemy_hp) + "/" + string(max_enemy_hp));

draw_set_color(make_color_rgb(58, 58, 58));
draw_rectangle(e_x1 + 104, e_y1 + 42, e_x2 - 18, e_y1 + 58, false);
draw_set_color(make_color_rgb(220, 80, 100));
var e_hp_w = (e_x2 - e_x1 - 122) * (enemy_hp / max_enemy_hp);
draw_rectangle(e_x1 + 104, e_y1 + 42, e_x1 + 104 + e_hp_w, e_y1 + 58, false);

// Dialogos verdadeiros escurecem a batalha, como acontece na exploracao.
if (message_is_dialogue && state != "choose" && state != "attack_question") {
    draw_set_alpha(0.68);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
}

// Area inferior: menus, dialogos e perguntas.
var box_x1 = 54;
var box_y1 = room_height - 250;
var box_x2 = room_width - 54;
var box_y2 = room_height - 28;

draw_set_alpha(0.94);
draw_set_color(c_black);
draw_roundrect(box_x1, box_y1, box_x2, box_y2, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_roundrect(box_x1, box_y1, box_x2, box_y2, true);

if (state == "choose") {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text_transformed(box_x1 + 26, box_y1 + 18, "Escolha uma acao", 1.12, 1.12, 0);

    for (var i = 0; i < array_length(action_names); i += 1) {
        var ax = box_x1 + 34;
        var ay = box_y1 + 62 + i * 34;
        var unavailable = global.hard_mode && i == 2;

        if (i == action_index) {
            draw_set_alpha(unavailable ? 0.55 : 1);
            draw_set_color(c_white);
            draw_rectangle(ax - 10, ay - 5, ax + 210, ay + 23, false);
            draw_set_color(c_black);
            draw_text(ax, ay, "> " + string(i + 1) + ". " + action_names[i]);
            draw_set_alpha(1);
        } else {
            draw_set_alpha(unavailable ? 0.42 : 1);
            draw_set_color(c_white);
            draw_text(ax, ay, "  " + string(i + 1) + ". " + action_names[i]);
            draw_set_alpha(1);
        }
    }

    draw_set_color(c_white);
    draw_set_alpha(0.78);
    draw_line(box_x1 + 270, box_y1 + 34, box_x1 + 270, box_y2 - 34);
    draw_set_alpha(1);

    var desc = action_desc[action_index];
    if (action_index == 3) {
        desc += "\n\nBarras de cereal: " + string(global.item_cereal_bars);
    }
    draw_text_ext(box_x1 + 302, box_y1 + 62, desc, 26, box_x2 - box_x1 - 350);

    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_alpha(0.66);
    draw_text(box_x2 - 18, box_y2 - 14, "W/S ou setas para escolher   |   ENTER para confirmar");
    draw_set_alpha(1);
}
else if (state == "attack_question") {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text_transformed(box_x1 + 26, box_y1 + 18, "Ataque Conceitual", 1.12, 1.12, 0);
    draw_set_alpha(0.72);
    draw_line(box_x1 + 26, box_y1 + 54, box_x2 - 26, box_y1 + 54);
    draw_set_alpha(1);

    draw_text_ext(box_x1 + 30, box_y1 + 76, question_text, 28, 560);

    for (var q = 0; q < array_length(question_options); q += 1) {
        draw_text(box_x1 + 690, box_y1 + 78 + q * 38, question_options[q]);
    }

    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_alpha(0.66);
    draw_text(box_x2 - 18, box_y2 - 14, message_footer);
    draw_set_alpha(1);
}
else {
    // Dialogo/mensagem. Retratos aparecem so em dialogos reais, nao em acoes do inimigo.
    var raw_text = battle_message;
    var speaker = "";
    var body_text = raw_text;

    var prefix_enemy = enemy_name + ":";
    var prefix_eu = "Eu:";
    var prefix_tutor = "Tutor:";

    if (message_is_dialogue) {
        if (string_pos(prefix_enemy, raw_text) == 1) {
            speaker = enemy_name;
            body_text = string_copy(raw_text, string_length(prefix_enemy) + 2, string_length(raw_text));
        } else if (string_pos(prefix_eu, raw_text) == 1) {
            speaker = "Eu";
            body_text = string_copy(raw_text, string_length(prefix_eu) + 2, string_length(raw_text));
        } else if (string_pos(prefix_tutor, raw_text) == 1) {
            speaker = "Tutor";
            body_text = string_copy(raw_text, string_length(prefix_tutor) + 2, string_length(raw_text));
        }
    }

    var text_x = box_x1 + 30;
    var text_w = box_x2 - box_x1 - 60;

    if (speaker == "Eu") {
        draw_sprite_ext(sprite_player_dialogue, 0, 90, room_height - 498, 0.58, 0.58, 0, c_white, 1);
        text_x = box_x1 + 310;
        text_w = box_x2 - text_x - 35;
    } else if (speaker == enemy_name) {
        draw_sprite_ext(enemy_dialogue_sprite, 0, room_width - 350, room_height - 506, 0.58, 0.58, 0, c_white, 1);
        text_x = box_x1 + 30;
        text_w = box_x2 - box_x1 - 378;
    } else if (speaker == "Tutor") {
        draw_sprite_ext(sprite_tutor_dialogue, 0, room_width - 350, room_height - 506, 0.58, 0.58, 0, c_white, 1);
        text_x = box_x1 + 30;
        text_w = box_x2 - box_x1 - 378;
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    if (speaker != "") {
        draw_text_transformed(text_x, box_y1 + 18, speaker, 1.08, 1.08, 0);
        draw_set_alpha(0.55);
        draw_line(text_x, box_y1 + 48, text_x + min(text_w, 330), box_y1 + 48);
        draw_set_alpha(1);
        draw_text_ext(text_x, box_y1 + 66, body_text, 25, text_w);
    } else {
        draw_text_ext(text_x, box_y1 + 30, body_text, 25, text_w);
    }

    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_alpha(0.66);
    draw_text(box_x2 - 18, box_y2 - 14, message_footer);
    draw_set_alpha(1);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
