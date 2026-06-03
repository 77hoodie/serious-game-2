// O tutor acompanha o player visualmente durante dialogos ou quando o jogador chega perto.
if (instance_exists(obj_player)) {
    var p = instance_nearest(x, y, obj_player);
    var player_is_near = (p != noone) && (point_distance(x, y, p.x, p.y) <= interact_range + 24);
    var tutor_dialogue_active = ((global.dialogue_text != "") && (string_pos("Tutor:", global.dialogue_text) == 1)) || (global.input_mode == "lab_intro");

    if (player_is_near || tutor_dialogue_active) {
        set_tutor_facing_player();
    }
}
