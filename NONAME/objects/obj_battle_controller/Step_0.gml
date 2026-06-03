// Maquina de estados da batalha.
// Estados principais: intro, choose, attack_question, player_message, enemy_message, victory, defeat.

var confirm_pressed = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
var cancel_pressed = keyboard_check_pressed(vk_escape);

if (state == "intro") {
    if (confirm_pressed) {
        intro_index += 1;
        if (intro_index >= array_length(intro_lines)) {
            state = "choose";
            battle_message = "";
            message_footer = "Escolha uma acao";
            message_is_dialogue = false;
        } else {
            battle_message = intro_lines[intro_index];
            message_footer = "ENTER para continuar";
            message_is_dialogue = true;
        }
    }
}
else if (state == "choose") {
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        action_index = (action_index + 1) mod array_length(action_names);
    }
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        action_index -= 1;
        if (action_index < 0) action_index = array_length(action_names) - 1;
    }

    if (keyboard_check_pressed(ord("1"))) action_index = 0;
    if (keyboard_check_pressed(ord("2"))) action_index = 1;
    if (keyboard_check_pressed(ord("3"))) action_index = 2;
    if (keyboard_check_pressed(ord("4"))) action_index = 3;

    if (confirm_pressed || keyboard_check_pressed(ord("1")) || keyboard_check_pressed(ord("2")) || keyboard_check_pressed(ord("3")) || keyboard_check_pressed(ord("4"))) {
        if (action_index == 0) {
            // Cada ataque recebe uma pergunta sorteada. Se uma dica foi pedida antes,
            // o proximo ataque usa a pergunta da dica para manter coerencia.
            if (!question_locked) {
                battle_pick_question();
            }
            state = "attack_question";
            selected_answer = 0;
            battle_message = "";
            message_footer = "1, 2 ou 3 para responder   |   ESC para voltar";
            message_is_dialogue = false;
        }
        else if (action_index == 1) {
            state = "player_message";
            pending_state = "enemy_turn";
            battle_message = review_text;
            message_footer = "ENTER para passar o turno";
            message_is_dialogue = true;
        }
        else if (action_index == 2) {
            state = "player_message";

            if (global.hard_mode) {
                pending_state = "choose";
                battle_message = "No Modo Dificil, voce nao consegue pedir dica durante a batalha. Use Revisar para lembrar apenas o essencial.";
                message_footer = "ENTER para voltar ao menu";
                message_is_dialogue = false;
            } else {
                // A dica prepara a pergunta do proximo ataque. Ela custa o turno,
                // mas deixa claro o caminho sem entregar a resposta diretamente.
                battle_pick_question();
                question_locked = true;
                pending_state = "enemy_turn";
                battle_message = "Tutor: A proxima pergunta vai usar esta ideia:\n\n" + question_text + "\n\n" + question_hint;
                message_footer = "ENTER para passar o turno";
                message_is_dialogue = true;
            }
        }
        else if (action_index == 3) {
            state = "player_message";
            pending_state = "enemy_turn";
            battle_message = "Eu: Procurei na mochila, mas ainda nao tenho nenhum item util.";
            message_footer = "ENTER para passar o turno";
            message_is_dialogue = true;
        }
    }
}
else if (state == "attack_question") {
    if (cancel_pressed) {
        state = "choose";
        selected_answer = 0;
        battle_message = "";
        message_footer = "Escolha uma acao";
        message_is_dialogue = false;
    }

    var answer = 0;
    if (keyboard_check_pressed(ord("1"))) answer = 1;
    if (keyboard_check_pressed(ord("2"))) answer = 2;
    if (keyboard_check_pressed(ord("3"))) answer = 3;

    if (answer != 0) {
        selected_answer = answer;
        question_locked = false;
        state = "player_message";
        pending_state = "enemy_turn";
        message_is_dialogue = false;

        if (answer == correct_answer) {
            var damage = player_attack_damage;
            enemy_hp -= damage;
            if (enemy_hp < 0) enemy_hp = 0;

            battle_message = question_solution + "\n\nO ataque acertou o Monitor Sem Rosto e causou " + string(damage) + " de dano.";

            if (enemy_hp <= 0) {
                pending_state = "victory";
            }
        } else {
            wrong_answers += 1;
            battle_message = "A resposta nao fechou.\n\n" + question_wrong_feedback;
            if (!global.hard_mode && wrong_answers >= 1) {
                battle_message += "\n\nDica: " + question_hint;
            }
        }
        message_footer = "ENTER para continuar";
    }
}
else if (state == "player_message") {
    if (confirm_pressed) {
        if (pending_state == "victory") {
            state = "victory";
            battle_message = "Monitor Sem Rosto: Voce usou os dois valores. Pode passar.\n\nA primeira batalha terminou.";
            message_footer = "ENTER para continuar";
            message_is_dialogue = true;
        } else if (pending_state == "choose") {
            state = "choose";
            battle_message = "";
            message_footer = "Escolha uma acao";
            message_is_dialogue = false;
        } else {
            state = "enemy_message";
            message_is_dialogue = false;

            var dmg = enemy_damage;
            player_hp -= dmg;
            if (player_hp < 0) player_hp = 0;
            global.player_hp = player_hp;

            if (dmg > 0) {
                battle_message = "O Monitor Sem Rosto avanca em silencio.\n\nVoce perdeu " + string(dmg) + " HP.";
            } else {
                battle_message = "O Monitor Sem Rosto observa o quadro e espera a sua proxima tentativa.";
            }

            if (player_hp <= 0) {
                state = "defeat";
                battle_message = "Voce ficou sem HP.\n\nPressione ENTER para tentar a batalha novamente.";
                message_footer = "ENTER para reiniciar";
                message_is_dialogue = false;
            } else {
                message_footer = "ENTER para voltar ao seu turno";
            }
        }
    }
}
else if (state == "enemy_message") {
    if (confirm_pressed) {
        turn_count += 1;
        state = "choose";
        battle_message = "";
        message_footer = "Escolha uma acao";
        message_is_dialogue = false;
    }
}
else if (state == "victory") {
    if (confirm_pressed) {
        if (global.battle_music != noone) {
            audio_stop_sound(global.battle_music);
            global.battle_music = noone;
        }
        room_goto(rm_end);
    }
}
else if (state == "defeat") {
    if (confirm_pressed) {
        room_restart();
    }
}
