if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = -1;

global.battle_music = audio_play_sound(snd_battle_theme, 10, true);
enemy_name = "Dr. Dominio";
player_hp = 20;
enemy_hp = 15;
max_player_hp = 20;
max_enemy_hp = 15;
state = "choose";
asked_question = false;
wrong_answers = 0;

global.dialogue_text = enemy_name + " apareceu!\n\nEle so recebe dano se voce usar o conceito aprendido.\n\n1) Ataque Conceitual\n2) Pedir Dica\n3) Revisar Conceito";
global.dialogue_timer = -1;
