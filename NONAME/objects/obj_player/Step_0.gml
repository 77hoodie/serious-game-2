if (global.input_mode == "none") {
    var h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var v = keyboard_check(ord("S")) - keyboard_check(ord("W"));

    var len = point_distance(0, 0, h, v);
    if (len > 0) {
        h /= len;
        v /= len;
    }

    x = clamp(x + h * move_speed, 40, room_width - 40);
    y = clamp(y + v * move_speed, 140, room_height - 190);
}

if (keyboard_check_pressed(ord("E")) && global.input_mode == "none") {
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
        global.dialogue_text = "Nada para interagir aqui. Chegue perto do painel, tutor ou porta e aperte E.";
        global.dialogue_timer = 140;
    }
}
