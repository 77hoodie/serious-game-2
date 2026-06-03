// Marcador discreto do quadro interativo.
// O mapa ja contem o quadro desenhado; aqui fica apenas a indicacao de interacao.
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var label_text = global.lab_01_puzzle_solved ? "Resolvido" : "E - Quadro";
var box_w = 120;
var box_h = 30;

if (global.lab_01_puzzle_solved) {
    draw_set_color(c_lime);
} else {
    draw_set_color(c_yellow);
}

draw_set_alpha(0.86);
draw_roundrect(x - box_w * 0.5, y - box_h * 0.5, x + box_w * 0.5, y + box_h * 0.5, false);
draw_set_alpha(1);

draw_set_color(c_black);
draw_text(x, y, label_text);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
