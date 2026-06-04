// Booly olha para o jogador quando ele se aproxima ou quando fala.
if (instance_exists(obj_player)) {
    var p = instance_nearest(x, y, obj_player);
    var player_is_near = (p != noone) && (point_distance(x, y, p.x, p.y) <= interact_range + 32);
    var booly_dialogue_active = (global.dialogue_text != "") && (string_pos("Booly:", global.dialogue_text) == 1);

    if (player_is_near || booly_dialogue_active) {
        set_booly_facing_player();
    }
}
