// Maquina de estados da batalha.
// Estados principais: intro, choose, attack_question, hessian_guard, player_message, enemy_message, victory, defeat.

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

            if (player_hp >= max_player_hp) {
                pending_state = "choose";
                battle_message = "Eu: Minha vida ja esta cheia. Melhor guardar os itens.";
                message_footer = "ENTER para voltar ao menu";
                message_is_dialogue = true;
            }
            else if (global.item_apples > 0 && (battle_id == "booly" || global.item_cereal_bars <= 0)) {
                var heal_apple = 30;
                var before_hp_apple = player_hp;
                player_hp = min(max_player_hp, player_hp + heal_apple);
                global.player_hp = player_hp;
                global.item_apples -= 1;

                var healed_apple = player_hp - before_hp_apple;
                pending_state = "enemy_turn";
                battle_message = "Eu: Comi uma maca. Recuperei " + string(healed_apple) + " HP.\n\nMacas restantes: " + string(global.item_apples) + ".";
                message_footer = "ENTER para passar o turno";
                message_is_dialogue = true;
            }
            else if (global.item_cereal_bars > 0) {
                var heal = 99;
                var before_hp = player_hp;
                player_hp = min(max_player_hp, player_hp + heal);
                global.player_hp = player_hp;
                global.item_cereal_bars -= 1;

                var healed = player_hp - before_hp;
                pending_state = "enemy_turn";
                battle_message = "Eu: Comi uma barra de cereal. Recuperei " + string(healed) + " HP.\n\nBarras restantes: " + string(global.item_cereal_bars) + ".";
                message_footer = "ENTER para passar o turno";
                message_is_dialogue = true;
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
            else if (battle_id == "isiaha" && isiaha_phase == 1 && enemy_hp <= isiaha_phase_threshold) {
                isiaha_phase = 2;
                enemy_dialogue_sprite = enemy_dialogue_sprite_phase2;
                battle_message = "Isiaha: Chega. Ela ja viu o bastante.\n\nA cobra se ergue no pescoco dele, acompanhando as linhas no chao. A partir daqui, ele vai cobrar a Hessiana completa.";
                message_is_dialogue = true;
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
else if (state == "hessian_guard") {
    var special_answer = 0;
    if (keyboard_check_pressed(ord("1"))) special_answer = 1;
    if (keyboard_check_pressed(ord("2"))) special_answer = 2;
    if (keyboard_check_pressed(ord("3"))) special_answer = 3;

    if (special_answer != 0) {
        if (special_answer == special_correct_answer) {
            enemy_hp -= isiaha_special_reward_damage;
            if (enemy_hp < 0) enemy_hp = 0;

            state = "enemy_message";
            battle_message = special_solution + "\n\n" + ((battle_id == "booly") ? "Voce organizou a prova surpresa a tempo. Booly deixa cair algumas apostilas e perde " : "Voce leu a Hessiana a tempo. A cobra recua e Isiaha perde ") + string(isiaha_special_reward_damage) + " HP.";
            message_footer = "ENTER para voltar ao seu turno";
            message_is_dialogue = false;

            if (enemy_hp <= 0) {
                state = "player_message";
                pending_state = "victory";
                battle_message = special_solution + "\n\n" + ((battle_id == "booly") ? "A prova surpresa deixou Booly sem apostila certa." : "A defesa quebrou a concentracao de Isiaha.");
                message_footer = "ENTER para continuar";
            }
        } else {
            var dmg_special = irandom_range(isiaha_special_damage_min, isiaha_special_damage_max);
            player_hp -= dmg_special;
            if (player_hp < 0) player_hp = 0;
            global.player_hp = player_hp;

            if (player_hp <= 0) {
                state = "defeat";
                battle_message = "A resposta falhou.\n\n" + special_wrong_feedback + "\n\nVoce ficou sem HP.";
                message_footer = "ENTER para voltar";
                message_is_dialogue = false;
            } else {
                state = "enemy_message";
                battle_message = "A resposta falhou.\n\n" + special_wrong_feedback + "\n\n" + ((battle_id == "booly") ? "Booly derruba uma pilha de apostilas em voce" : "A cobra ataca") + " e voce perde " + string(dmg_special) + " HP.";
                message_footer = "ENTER para voltar ao seu turno";
                message_is_dialogue = false;
            }
        }
    }
}
else if (state == "player_message") {
    if (confirm_pressed) {
        if (pending_state == "victory") {
            state = "victory";

            var reward_text = "";

            if (battle_id == "monitor") {
                if (!global.notebook_monitor_sem_rosto) {
                    for (var notebook_i = 0; notebook_i < array_length(notebook_pages_to_add); notebook_i += 1) {
                        array_push(global.notebook_pages, notebook_pages_to_add[notebook_i]);
                    }
                    global.notebook_monitor_sem_rosto = true;
                    reward_text += "\n\nNovas paginas foram adicionadas ao seu caderno: Funcoes de varias variaveis.";
                }

                if (!global.reward_monitor_items) {
                    global.item_cereal_bars += 3;
                    global.reward_monitor_items = true;
                    reward_text += "\nVoce encontrou 3 barras de cereal.";
                }

                if (!global.hp_bonus_after_monitor) {
                    global.player_max_hp += 5;
                    global.player_hp = global.player_max_hp;
                    player_hp = global.player_hp;
                    max_player_hp = global.player_max_hp;
                    global.hp_bonus_after_monitor = true;
                    reward_text += "\nSua vida maxima aumentou em 5 HP.";
                }

                battle_message = "Monitor Sem Rosto: Voce usou os dois valores. Pode passar." + reward_text;
            }
            else if (battle_id == "aluna") {
                if (!global.notebook_aluna_janela) {
                    for (var notebook_i = 0; notebook_i < array_length(notebook_pages_to_add); notebook_i += 1) {
                        array_push(global.notebook_pages, notebook_pages_to_add[notebook_i]);
                    }
                    global.notebook_aluna_janela = true;
                    reward_text += "\n\nNovas paginas foram adicionadas ao seu caderno: Derivadas parciais.";
                }

                if (!variable_global_exists("hp_bonus_after_aluna")) global.hp_bonus_after_aluna = false;
                if (!global.hp_bonus_after_aluna) {
                    global.player_max_hp += 5;
                    global.player_hp = global.player_max_hp;
                    player_hp = global.player_hp;
                    max_player_hp = global.player_max_hp;
                    global.hp_bonus_after_aluna = true;
                    reward_text += "\nSua vida maxima aumentou em 5 HP.";
                }

                battle_message = "Aluna da Janela: Entendi. Uma coisa por vez." + reward_text;
            }
            else if (battle_id == "cartografo") {
                if (!global.notebook_cartografo) {
                    for (var notebook_i = 0; notebook_i < array_length(notebook_pages_to_add); notebook_i += 1) {
                        array_push(global.notebook_pages, notebook_pages_to_add[notebook_i]);
                    }
                    global.notebook_cartografo = true;
                    reward_text += "\n\nNovas paginas foram adicionadas ao seu caderno: Vetor gradiente.";
                }

                if (!variable_global_exists("hp_bonus_after_cartografo")) global.hp_bonus_after_cartografo = false;
                if (!global.hp_bonus_after_cartografo) {
                    global.player_max_hp += 8;
                    global.player_hp = global.player_max_hp;
                    player_hp = global.player_hp;
                    max_player_hp = global.player_max_hp;
                    global.hp_bonus_after_cartografo = true;
                    reward_text += "\nSua vida maxima aumentou em 8 HP.";
                }

                battle_message = "Cartografo: Eu admito. Sua seta estava aceitavel." + reward_text;
            }
            else if (battle_id == "isiaha") {
                if (!global.notebook_isiaha) {
                    for (var notebook_i = 0; notebook_i < array_length(notebook_pages_to_add); notebook_i += 1) {
                        array_push(global.notebook_pages, notebook_pages_to_add[notebook_i]);
                    }
                    global.notebook_isiaha = true;
                    reward_text += "\n\nNovas paginas foram adicionadas ao seu caderno: Maximos, minimos e Hessiana.";
                }

                if (!variable_global_exists("hp_bonus_after_isiaha")) global.hp_bonus_after_isiaha = false;
                if (!global.hp_bonus_after_isiaha) {
                    global.player_max_hp += 8;
                    global.player_hp = global.player_max_hp;
                    player_hp = global.player_hp;
                    max_player_hp = global.player_max_hp;
                    global.hp_bonus_after_isiaha = true;
                    reward_text += "\nSua vida maxima aumentou em 8 HP.";
                }

                battle_message = "Isiaha: Voce classificou sem fingir certeza. Isso basta." + reward_text;

                if (global.difficulty_mode == "hard" && !global.booly_unlocked) {
                    global.booly_unlocked = true;
                    reward_text = "\n\nModo Booly foi liberado na tela de dificuldade.";
                    if (!global.booly_reward_apples) {
                        global.item_apples += 3;
                        global.booly_reward_apples = true;
                        reward_text += "\nVoce recebeu 3 macas para o desafio secreto.";
                    }
                    battle_message += reward_text;
                } else if (global.difficulty_mode == "hard" && global.booly_unlocked && !global.booly_reward_apples) {
                    global.item_apples += 3;
                    global.booly_reward_apples = true;
                    battle_message += "\n\nVoce recebeu 3 macas para o desafio secreto.";
                }
            }
            else if (battle_id == "booly") {
                if (!global.booly_completed) {
                    for (var notebook_i = 0; notebook_i < array_length(notebook_pages_to_add); notebook_i += 1) {
                        array_push(global.notebook_pages, notebook_pages_to_add[notebook_i]);
                    }
                    global.booly_completed = true;
                    reward_text += "\n\nNovas paginas extras foram adicionadas ao seu caderno: Desafio geral do Booly.";
                }

                battle_message = "Booly: Certo. Talvez carregar apostilas funcione melhor quando alguem le junto." + reward_text;
            }

            message_footer = "ENTER para continuar";
            message_is_dialogue = true;
        } else if (pending_state == "choose") {
            state = "choose";
            battle_message = "";
            message_footer = "Escolha uma acao";
            message_is_dialogue = false;
        } else {
            if ((battle_id == "isiaha" && isiaha_phase >= 2 && (turn_count mod 3 == 0)) || (battle_id == "booly" && (turn_count mod 4 == 0))) {
                battle_pick_special_question();
                state = "hessian_guard";
                message_footer = "1, 2 ou 3 para responder";
                message_is_dialogue = false;
                exit;
            }

            state = "enemy_message";
            message_is_dialogue = false;

            var dmg = irandom_range(enemy_damage_min, enemy_damage_max);
            player_hp -= dmg;
            if (player_hp < 0) player_hp = 0;
            global.player_hp = player_hp;

            if (battle_id == "isiaha") {
                if (isiaha_phase >= 2) {
                    battle_message = "A cobra acompanha uma curva no chao e Isiaha avanca logo depois.\n\nVoce perdeu " + string(dmg) + " HP.";
                } else {
                    battle_message = "Isiaha aponta para o pedestal sem mudar a expressao.\n\nVoce perdeu " + string(dmg) + " HP.";
                }
            } else if (battle_id == "cartografo") {
                battle_message = "O Cartografo redesenha a rota no ar e uma seta te atravessa.\n\nVoce perdeu " + string(dmg) + " HP.";
            } else if (battle_id == "aluna") {
                battle_message = "A Aluna da Janela encara o vidro e respira fundo.\n\nVoce perdeu " + string(dmg) + " HP.";
            } else if (battle_id == "booly") {
                battle_message = "Booly abre uma apostila errada, fecha, abre outra, e mesmo assim acerta voce com a pilha.\n\nVoce perdeu " + string(dmg) + " HP.";
            } else {
                battle_message = "O Monitor Sem Rosto avanca em silencio.\n\nVoce perdeu " + string(dmg) + " HP.";
            }

            if (player_hp <= 0) {
                state = "defeat";
                battle_message = "Voce ficou sem HP.\n\nAo acordar, voce volta para a sala anterior. O desafio tera que ser refeito.";
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

    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        defeat_option = 1;
    }

    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        defeat_option = 0;
    }

    if (confirm_pressed) {

        if (global.battle_music != noone) {
            audio_stop_sound(global.battle_music);
            global.battle_music = noone;
        }

        if (defeat_option == 0) {

            if (battle_id == "booly") {
                global.lab_booly_intro_done = false;
                if (global.item_apples < 3) global.item_apples = 3;
            }
            else if (battle_id == "isiaha") {
                global.lab_04_puzzle_solved = false;
                global.lab_04_puzzle_stage = 0;
                global.puzzle_attempts_lab_04 = 0;
                global.lab_04_intro_done = false;
            }
            else if (battle_id == "cartografo") {
                global.lab_03_puzzle_solved = false;
                global.puzzle_attempts_lab_03 = 0;
                global.lab_03_intro_done = false;
            }
            else if (battle_id == "aluna") {
                global.lab_02_puzzle_solved = false;
                global.puzzle_attempts_lab_02 = 0;
                global.lab_02_intro_done = false;
            }
            else {
                global.lab_01_puzzle_solved = false;
                global.puzzle_attempts = 0;
                global.lab_01_intro_done = false;
            }

            global.input_mode = "none";
            global.dialogue_text = "";
            global.dialogue_timer = 0;

            room_goto(reset_room);

        } else {

            room_goto(rm_title);

        }
    }
}
