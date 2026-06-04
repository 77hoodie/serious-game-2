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

    if (room == rm_lab_03) {
        global.dialogue_text = "Tutor: O gradiente junta as derivadas parciais em um vetor. Primeiro voce calcula df/dx e df/dy. Depois olha para o par que apareceu.\n\nEsse vetor mostra para onde a funcao cresce mais rapido. E, pelo jeito, essa sala gosta bastante de setas.";
    } else if (room == rm_lab_02) {
        global.dialogue_text = "Tutor: Derivada parcial e olhar para uma variavel por vez. Se o quadro pedir df/dx, trate y como constante. Se pedir df/dy, trate x como constante.\n\nA sala fica confusa quando voce tenta mudar tudo ao mesmo tempo.";
    } else {
        global.dialogue_text = "Tutor: O quadro esta usando uma funcao de varias variaveis. Ela recebe um par, como (x,y), e devolve um valor.\n\nSe voce errar, ele deve mostrar pistas antes de deixar voce tentar de novo.";
    }
    global.dialogue_timer = -1;
};
