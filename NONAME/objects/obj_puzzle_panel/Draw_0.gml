// Placeholder: quadro interativo.
draw_set_color(make_color_rgb(36, 92, 72));
draw_roundrect(x - 58, y - 38, x + 58, y + 38, false);
draw_set_color(c_white);
draw_text(x - 48, y - 8, "QUADRO");

if (!global.lab_01_puzzle_solved) {
    draw_set_color(c_yellow);
    draw_text(x - 66, y + 48, "E para resolver");
} else {
    draw_set_color(c_lime);
    draw_text(x - 44, y + 48, "Resolvido");
}
