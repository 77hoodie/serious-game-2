// Cenario de combate placeholder estilo RPG em turnos.
draw_set_color(make_color_rgb(25, 25, 35));
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(40, 28, "COMBATE RPG - Sala 1: Funcoes de varias variaveis");
draw_text(40, 56, "H alterna modo aprendizado/dificil. Modo atual: " + (global.hard_mode ? "DIFICIL" : "APRENDIZADO"));

// Jogador em pose de batalha.
// A sprite sprite_player_battle sera usada como padrao visual do player em todas as batalhas.
draw_sprite_ext(player_battle_sprite, 0, player_battle_x, player_battle_y, player_battle_scale, player_battle_scale, 0, c_white, 1);
draw_set_color(c_white);
draw_text(player_battle_x - 48, player_battle_y + 14, "Jogador");
draw_text(player_battle_x - 70, player_battle_y + 44, "HP: " + string(player_hp) + "/" + string(max_player_hp));

// Inimigo como bola escura.
draw_set_color(make_color_rgb(85, 30, 120));
draw_circle(room_width - 300, 275, 62, false);
draw_set_color(c_white);
draw_text(room_width - 365, 348, enemy_name);
draw_text(room_width - 350, 378, "HP: " + string(enemy_hp) + "/" + string(max_enemy_hp));

// Barra simples de HP do inimigo.
draw_set_color(c_gray);
draw_rectangle(room_width - 460, 420, room_width - 140, 442, false);
draw_set_color(c_lime);
var hp_w = 320 * (enemy_hp / max_enemy_hp);
draw_rectangle(room_width - 460, 420, room_width - 460 + hp_w, 442, false);

// Menu fixo.
draw_set_color(c_yellow);
if (state != "victory") {
    draw_text(40, 620, "1 Ataque Conceitual   |   2 Dica   |   3 Revisar");
} else {
    draw_text(40, 620, "ENTER para finalizar");
}

if (global.dialogue_text != "") {
    var box_x1 = 40;
    var box_y1 = room_height - 260;
    var box_x2 = room_width - 40;
    var box_y2 = room_height - 72;

    draw_set_alpha(0.88);
    draw_set_color(c_black);
    draw_roundrect(box_x1, box_y1, box_x2, box_y2, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_text_ext(box_x1 + 18, box_y1 + 16, global.dialogue_text, 24, box_x2 - box_x1 - 36);
}
