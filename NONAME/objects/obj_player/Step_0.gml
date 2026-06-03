if (global.input_mode == "none" && global.dialogue_text == "") {
    var h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var v = keyboard_check(ord("S")) - keyboard_check(ord("W"));

    var len = point_distance(0, 0, h, v);
    var moving = (len > 0);

    if (moving) {
        h /= len;
        v /= len;

        // Define a direção visual pela última direção predominante.
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

        x = clamp(x + h * move_speed, 40, room_width - 40);
        y = clamp(y + v * move_speed, 140, room_height - 190);
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

    if (nearest != noone) {
        nearest.interact();
    } else {
        global.dialogue_text = "Nada para interagir aqui. Chegue perto do quadro, tutor ou porta e aperte E.";
        global.dialogue_timer = 140;
    }
}
