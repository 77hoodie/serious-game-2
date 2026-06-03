if (!variable_global_exists("difficulty_mode")) global.difficulty_mode = "learning";
if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = -1;

if (!variable_global_exists("battle_music")) global.battle_music = noone;
if (global.battle_music == noone) {
    global.battle_music = audio_play_sound(snd_battle_theme, 10, true);
}
enemy_name = "Dr. Dominio";
player_hp = 20;
enemy_hp = 15;
max_player_hp = 20;
max_enemy_hp = 15;

// Configuracao visual do jogador em todas as batalhas.
player_battle_sprite = sprite_player_battle;
player_battle_scale = 0.34;
player_battle_x = 260;
player_battle_y = 500;
state = "choose";
asked_question = false;
wrong_answers = 0;

global.dialogue_text = enemy_name + " apareceu!\n\nEle so recebe dano se voce usar o conceito aprendido.\nDificuldade: " + (global.hard_mode ? "Modo Dificil" : "Modo Aprendizado") + "\n\n1) Ataque Conceitual\n2) Pedir Dica\n3) Revisar Conceito";
global.dialogue_timer = -1;
