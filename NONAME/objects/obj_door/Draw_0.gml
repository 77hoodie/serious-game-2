// Marcador discreto da porta.
// A porta visual vem do mapa; este objeto controla a interacao e a transicao.
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var solved = (room == rm_lab_03) ? global.lab_03_puzzle_solved : ((room == rm_lab_02) ? global.lab_02_puzzle_solved : global.lab_01_puzzle_solved);
var label_text = solved ? "E - Sair" : "Trancada";
var box_w = 112;
var box_h = 30;

if (solved) {
    draw_set_color(c_lime);
} else {
    draw_set_color(make_color_rgb(220, 155, 70));
}

draw_set_alpha(0.86);
draw_roundrect(x - box_w * 0.5, y - box_h * 0.5, x + box_w * 0.5, y + box_h * 0.5, false);
draw_set_alpha(1);

draw_set_color(c_black);
draw_text(x, y, label_text);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
