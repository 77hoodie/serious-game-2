move_speed = 4;
radius = 18;
interact_range = 86;

// Sprites do jogador.
// Ajuste este valor se o personagem ficar grande ou pequeno na room.
player_sprite_scale = 0.55;

facing = "down";
sprite_index = sprite_player_down;
image_xscale = player_sprite_scale;
image_yscale = player_sprite_scale;
image_speed = 0;
image_index = 1;

// Hitbox pequena nos pes do personagem.
// Isso combina melhor com mapas top-down, permitindo que o corpo passe perto de mesas/parede
// sem parecer que a colisao esta longe demais.
collision_half_w = 12;
collision_top = 24;
collision_bottom = 4;

map_collision_free = function(_x, _y) {
    var rects = [];

    if (room == rm_lab_01) {
        if (!variable_global_exists("lab_01_collision_rects")) return true;
        rects = global.lab_01_collision_rects;
    } else if (room == rm_lab_02) {
        if (!variable_global_exists("lab_02_collision_rects")) return true;
        rects = global.lab_02_collision_rects;
    } else if (room == rm_lab_03) {
        if (!variable_global_exists("lab_03_collision_rects")) return true;
        rects = global.lab_03_collision_rects;
    } else if (room == rm_lab_04) {
        if (!variable_global_exists("lab_04_collision_rects")) return true;
        rects = global.lab_04_collision_rects;
    } else if (room == rm_lab_booly) {
        if (!variable_global_exists("lab_booly_collision_rects")) return true;
        rects = global.lab_booly_collision_rects;
    } else {
        return true;
    }

    var left = _x - collision_half_w;
    var right = _x + collision_half_w;
    var top = _y - collision_top;
    var bottom = _y - collision_bottom;

    var count = array_length(rects);

    for (var i = 0; i < count; i += 1) {
        var r = rects[i];
        var rx1 = r[0];
        var ry1 = r[1];
        var rx2 = r[2];
        var ry2 = r[3];

        if (right > rx1 && left < rx2 && bottom > ry1 && top < ry2) {
            return false;
        }
    }

    return true;
};
