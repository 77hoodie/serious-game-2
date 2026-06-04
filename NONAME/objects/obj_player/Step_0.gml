if (global.input_mode == "none" && global.dialogue_text == "") {
    var h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var v = keyboard_check(ord("S")) - keyboard_check(ord("W"));

    var len = point_distance(0, 0, h, v);
    var moving = (len > 0);

    if (moving) {
        h /= len;
        v /= len;

        // Define a direcao visual pela ultima direcao predominante.
        if (abs(h) > abs(v)) {
            if (h > 0) {
                facing = "right";
                sprite_index = sprite_player_right;
            } else {
                facing = "left";
                sprite_index = sprite_player_left;
            }
        } else {
            if (v > 0) {
                facing = "down";
                sprite_index = sprite_player_down;
            } else {
                facing = "up";
                sprite_index = sprite_player_up;
            }
        }

        image_xscale = player_sprite_scale;
        image_yscale = player_sprite_scale;
        image_speed = 0.18;

        var nx = clamp(x + h * move_speed, 0, room_width);
        if (map_collision_free(nx, y)) {
            x = nx;
        }

        var ny = clamp(y + v * move_speed, 0, room_height);
        if (map_collision_free(x, ny)) {
            y = ny;
        }
    } else {
        image_speed = 0;
        image_index = 1;
    }
} else {
    image_speed = 0;
}

if (keyboard_check_pressed(ord("E")) && global.input_mode == "none" && global.dialogue_text == "") {
    var nearest = noone;
    var best_dist = interact_range;

    var p = instance_nearest(x, y, obj_puzzle_panel);
    if (p != noone) {
        var d = point_distance(x, y, p.x, p.y);
        if (d < best_dist) { nearest = p; best_dist = d; }
    }

    var door = instance_nearest(x, y, obj_door);
    if (door != noone) {
        var dd = point_distance(x, y, door.x, door.y);
        if (dd < best_dist) { nearest = door; best_dist = dd; }
    }

    var tutor = instance_nearest(x, y, obj_tutor);
    if (tutor != noone) {
        var dt = point_distance(x, y, tutor.x, tutor.y);
        if (dt < best_dist) { nearest = tutor; best_dist = dt; }
    }

    var booly = instance_nearest(x, y, obj_booly);
    if (booly != noone) {
        var db = point_distance(x, y, booly.x, booly.y);
        if (db < best_dist) { nearest = booly; best_dist = db; }
    }

    if (nearest != noone) {
        nearest.interact();
    } else {
        global.dialogue_text = "Nada para interagir aqui. Chegue perto de um personagem, quadro, mesa, pedestal ou porta e aperte E.";
        global.dialogue_timer = -1;
    }
}
