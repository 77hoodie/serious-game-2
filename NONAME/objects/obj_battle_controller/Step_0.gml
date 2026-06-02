if (state == "choose") {
    if (keyboard_check_pressed(ord("1"))) {
        state = "question";
        global.dialogue_text = "ATAQUE CONCEITUAL\n\nf(x,y) = x^2 + y^2\nQual e o valor de f(1,2)?\n\n1) 3\n2) 5\n3) 8";
        global.dialogue_timer = -1;
    }

    if (keyboard_check_pressed(ord("2"))) {
        global.dialogue_text = "Dica de batalha: o inimigo desta fase representa DOMINIO/IMAGEM. Substitua x e y na funcao antes de atacar.";
        global.dialogue_timer = -1;
    }

    if (keyboard_check_pressed(ord("3"))) {
        global.dialogue_text = "Revisao: f(x,y) recebe dois valores de entrada. Em f(1,2), troque x por 1 e y por 2.\n\nPressione 1 para atacar quando estiver pronto.";
        global.dialogue_timer = -1;
    }
}
else if (state == "question") {
    var answer = 0;
    if (keyboard_check_pressed(ord("1"))) answer = 1;
    if (keyboard_check_pressed(ord("2"))) answer = 2;
    if (keyboard_check_pressed(ord("3"))) answer = 3;

    if (answer != 0) {
        if (answer == 2) {
            enemy_hp -= 5;
            if (enemy_hp <= 0) {
                enemy_hp = 0;
                state = "victory";
                global.dialogue_text = "Voce venceu o " + enemy_name + "!\n\nO puzzle ensinou o conceito e o combate confirmou a aprendizagem.\n\nPressione ENTER para finalizar o prototipo.";
            } else {
                state = "choose";
                global.dialogue_text = "Acertou! f(1,2) = 5. O ataque causou 5 de dano.\n\n1) Ataque Conceitual\n2) Pedir Dica\n3) Revisar Conceito";
            }
        } else {
            wrong_answers += 1;
            if (global.hard_mode) {
                player_hp -= 2;
                if (player_hp < 1) player_hp = 1;
            }

            state = "choose";
            global.dialogue_text = "Ataque falhou, mas sem travar o aprendizado.\n\nExplicacao: f(1,2) = 1^2 + 2^2 = 1 + 4 = 5.";
            if (global.hard_mode) {
                global.dialogue_text += "\n\nModo dificil: voce perdeu 2 HP.";
            } else {
                global.dialogue_text += "\n\nModo aprendizado: nenhum dano. Tente novamente.";
            }
            global.dialogue_text += "\n\n1) Ataque Conceitual\n2) Pedir Dica\n3) Revisar Conceito";
        }
        global.dialogue_timer = -1;
    }
}
else if (state == "victory") {
    if (keyboard_check_pressed(vk_enter)) {
		audio_stop_sound(global.battle_music);
        room_goto(rm_end);
    }
}
