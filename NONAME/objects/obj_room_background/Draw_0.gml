// Desenha o mapa da sala como cenario de fundo.
// A imagem e apenas visual; colisoes e interacoes continuam em objetos separados.
if (room == rm_lab_01) {
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_sprite_stretched(sprite_map_classroom_01, 0, 0, 0, room_width, room_height);
}
