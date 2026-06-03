// Tutor da sala.
// Usa sprites direcionais e olha para o player durante o dialogo.

interact_range = 96;
tutor_sprite_scale = 0.36;
facing = "down";

sprite_index = sprite_tutor_down;
image_xscale = tutor_sprite_scale;
image_yscale = tutor_sprite_scale;
image_speed = 0;
image_index = 0;

set_tutor_facing_player = function() {
    if (!instance_exists(obj_player)) return;

    var p = instance_nearest(x, y, obj_player);
    if (p == noone) return;

    var dx = p.x - x;
    var dy = p.y - y;

    if (abs(dx) > abs(dy)) {
        if (dx >= 0) {
            facing = "right";
            sprite_index = sprite_tutor_right;
        } else {
            facing = "left";
            sprite_index = sprite_tutor_left;
        }
    } else {
        if (dy >= 0) {
            facing = "down";
            sprite_index = sprite_tutor_down;
        } else {
            facing = "up";
            sprite_index = sprite_tutor_up;
        }
    }

    image_xscale = tutor_sprite_scale;
    image_yscale = tutor_sprite_scale;
    image_speed = 0;
    image_index = 0;
};

interact = function() {
    set_tutor_facing_player();

    global.dialogue_text = "Tutor: Neste prototipo, o erro nao reinicia a sala. Ele gera pistas.\n\nConceito da sala: uma funcao de varias variaveis recebe pares como (x,y) e devolve uma saida z = f(x,y).";
    global.dialogue_timer = -1;
};
