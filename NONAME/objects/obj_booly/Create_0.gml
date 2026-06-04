// Booly, personagem secreto pos-game.
// Fica na sala secreta e inicia a batalha extra quando o jogador conversa com ele.

interact_range = 110;
booly_sprite_scale = 0.40;
facing = "down";

sprite_index = sprite_booly_down;
image_xscale = booly_sprite_scale;
image_yscale = booly_sprite_scale;
image_speed = 0;
image_index = 0;

set_booly_facing_player = function() {
    if (!instance_exists(obj_player)) return;

    var p = instance_nearest(x, y, obj_player);
    if (p == noone) return;

    var dx = p.x - x;
    var dy = p.y - y;

    if (abs(dx) > abs(dy)) {
        if (dx >= 0) {
            facing = "right";
            sprite_index = sprite_booly_right;
        } else {
            facing = "left";
            sprite_index = sprite_booly_left;
        }
    } else {
        if (dy >= 0) {
            facing = "down";
            sprite_index = sprite_booly_down;
        } else {
            facing = "up";
            sprite_index = sprite_booly_up;
        }
    }

    image_xscale = booly_sprite_scale;
    image_yscale = booly_sprite_scale;
    image_speed = 0;
    image_index = 0;
};

interact = function() {
    set_booly_facing_player();

    global.booly_intro_page = 0;
    global.booly_intro_lines = [
        "Booly: Ah. Voce voltou.",
        "Eu: Eu nem sabia que dava para voltar por aqui.",
        "Booly: Pois e. Eu tambem nao sabia que dava para chegar aqui sem carregar todas essas apostilas.",
        "Eu: Voce leu alguma delas?",
        "Booly: Eu carreguei. E parecido, so que com mais dor nas costas.",
        "Tutor: Essa sala mistura todos os assuntos do caderno.",
        "Booly: Misturar e uma palavra forte. Eu prefiro chamar de organizacao transversal.",
        "Eu: Isso faz sentido?",
        "Booly: Depende da apostila.",
        "Booly: Voce passou por todo mundo no modo dificil. Agora eu vou abrir tudo ao mesmo tempo. Boa sorte para nos dois."
    ];

    global.input_mode = "booly_intro";
    global.dialogue_text = global.booly_intro_lines[0];
    global.dialogue_timer = -1;
};
