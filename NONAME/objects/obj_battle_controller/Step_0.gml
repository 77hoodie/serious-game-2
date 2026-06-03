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

            if (global.item_cereal_bars > 0) {
                if (player_hp >= max_player_hp) {
                    pending_state = "choose";
                    battle_message = "Eu: Minha vida ja esta cheia. Melhor guardar a barra de cereal.";
                    message_footer = "ENTER para voltar ao menu";
                    message_is_dialogue = true;
                } else {
                    var heal = 12;
                    var before_hp = player_hp;
                    player_hp = min(max_player_hp, player_hp + heal);
                    global.player_hp = player_hp;
                    global.item_cereal_bars -= 1;

                    var healed = player_hp - before_hp;
                    pending_state = "enemy_turn";
                    battle_message = "Eu: Comi uma barra de cereal. Recuperei " + string(healed) + " HP.\n\nBarras restantes: " + string(global.item_cereal_bars) + ".";
                    message_footer = "ENTER para passar o turno";
                    message_is_dialogue = true;
                }
            } else {
                pending_state = "choose";
                battle_message = "Eu: Procurei na mochila, mas nao encontrei nenhum item util.";
                message_footer = "ENTER para voltar ao menu";
                message_is_dialogue = true;
            }
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

            battle_message = question_solution + "\n\nO ataque acertou " + enemy_name + " e causou " + string(damage) + " de dano.";

            if (enemy_hp <= 0) {
                pending_state = "victory";
            }
        } else {
            wrong_answers += 1;
            battle_message = "A resposta nao fechou.\n\n" + question_wrong_feedback;
            if (!global.hard_mode && wrong_answers >= 1 && question_hint != "") {
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

            var reward_text = "";

            if (battle_id == "monitor") {
                if (!global.notebook_monitor_sem_rosto) {
                    array_push(global.notebook_pages, {
                        title: notebook_page_title,
                        body: notebook_page_body
                    });
                    global.notebook_monitor_sem_rosto = true;
                    reward_text += "\n\nUma pagina foi adicionada ao seu caderno: Funcoes de varias variaveis.";
                }

                if (!global.reward_monitor_items) {
                    global.item_cereal_bars += 2;
                    global.reward_monitor_items = true;
                    reward_text += "\nVoce encontrou 2 barras de cereal.";
                }

                battle_message = "Monitor Sem Rosto: Voce usou os dois valores. Pode passar." + reward_text;
            }
            else if (battle_id == "aluna") {
                if (!global.notebook_aluna_janela) {
                    array_push(global.notebook_pages, {
                        title: notebook_page_title,
                        body: notebook_page_body
                    });
                    global.notebook_aluna_janela = true;
                    reward_text += "\n\nUma pagina foi adicionada ao seu caderno: Derivadas parciais.";
                }

                battle_message = "Aluna da Janela: Entendi. Uma coisa por vez." + reward_text;
            }

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

            var dmg = irandom_range(enemy_damage_min, enemy_damage_max);
            player_hp -= dmg;
            if (player_hp < 0) player_hp = 0;
            global.player_hp = player_hp;

            if (battle_id == "aluna") {
                battle_message = "A Aluna da Janela encara o vidro e respira fundo.\n\nVoce perdeu " + string(dmg) + " HP.";
            } else {
                battle_message = "O Monitor Sem Rosto avanca em silencio.\n\nVoce perdeu " + string(dmg) + " HP.";
            }

            if (player_hp <= 0) {
                state = "defeat";
                battle_message = "Voce ficou sem HP.\n\nAo acordar, voce volta para a sala anterior. O quadro tera que ser refeito.";
                message_footer = "ENTER para voltar";
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

        room_goto(victory_room);
    }
}
else if (state == "defeat") {
    if (confirm_pressed) {
        if (global.battle_music != noone) {
            audio_stop_sound(global.battle_music);
            global.battle_music = noone;
        }

        if (battle_id == "aluna") {
            global.lab_02_puzzle_solved = false;
            global.puzzle_attempts_lab_02 = 0;
            global.lab_02_intro_done = false;
        } else {
            global.lab_01_puzzle_solved = false;
            global.puzzle_attempts = 0;
            global.lab_01_intro_done = false;
        }

        global.input_mode = "none";
        global.dialogue_text = "";
        global.dialogue_timer = 0;
        room_goto(reset_room);
    }
}
