if (global.lab_01_puzzle_solved) {
    draw_set_color(c_lime);
} else {
    draw_set_color(make_color_rgb(180, 100, 20));
}
draw_rectangle(x - 42, y - 70, x + 42, y + 70, false);
draw_set_color(c_white);
draw_text(x - 31, y - 8, "PORTA");

if (global.lab_01_puzzle_solved) {
    draw_text(x - 48, y + 82, "E para sair");
} else {
    draw_text(x - 42, y + 82, "Trancada");
}
