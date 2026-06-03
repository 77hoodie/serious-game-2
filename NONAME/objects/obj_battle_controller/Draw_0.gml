// Cenario de combate placeholder estilo RPG em turnos.
draw_set_color(make_color_rgb(25, 25, 35));
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(40, 28, "COMBATE RPG - Sala 1: Funcoes de varias variaveis");
draw_text(40, 56, "Modo atual: " + (global.hard_mode ? "DIFICIL" : "APRENDIZADO"));

// Jogador em pose de batalha.
draw_sprite_ext(player_battle_sprite, 0, player_battle_x, player_battle_y, player_battle_scale, player_battle_scale, 0, c_white, 1);
draw_set_color(c_white);
draw_text(player_battle_x - 48, player_battle_y + 14, "Jogador");
draw_text(player_battle_x - 70, player_battle_y + 44, "HP: " + string(player_hp) + "/" + string(max_player_hp));

// Inimigo como placeholder escuro.
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

// Caixa padronizada de comando/dialogo do combate.
var box_x1 = 50;
var box_y1 = room_height - 250;
var box_x2 = room_width - 50;
var box_y2 = room_height - 28;

draw_set_alpha(0.92);
draw_set_color(c_black);
draw_roundrect(box_x1, box_y1, box_x2, box_y2, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_roundrect(box_x1, box_y1, box_x2, box_y2, true);

if (global.dialogue_text != "") {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text_ext(box_x1 + 24, box_y1 + 22, global.dialogue_text, 24, box_x2 - box_x1 - 48);
}

// Rodape de controle discreto, separado do texto principal.
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_set_alpha(0.62);
if (state != "victory") {
    draw_text(box_x2 - 22, box_y2 - 14, "1 Ataque   |   2 Dica   |   3 Revisar");
} else {
    draw_text(box_x2 - 22, box_y2 - 14, "ENTER para finalizar");
}
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
