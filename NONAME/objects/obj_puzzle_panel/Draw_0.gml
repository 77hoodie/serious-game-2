// Placeholder: painel interativo azul.
draw_set_color(make_color_rgb(30, 105, 230));
draw_roundrect(x - 58, y - 38, x + 58, y + 38, false);
draw_set_color(c_white);
draw_text(x - 48, y - 8, "PAINEL");

if (!global.lab_01_puzzle_solved) {
    draw_set_color(c_yellow);
    draw_text(x - 66, y + 48, "E para resolver");
} else {
    draw_set_color(c_lime);
    draw_text(x - 44, y + 48, "Resolvido");
}
