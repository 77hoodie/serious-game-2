if (global.input_mode == "puzzle_lab_01") {
    var answer = 0;
    if (keyboard_check_pressed(ord("1"))) answer = 1;
    if (keyboard_check_pressed(ord("2"))) answer = 2;
    if (keyboard_check_pressed(ord("3"))) answer = 3;

    if (answer != 0) {
        if (answer == 2) {
            global.lab_01_puzzle_solved = true;
            global.input_mode = "none";
            global.dialogue_text = "Correto! f(1,2) = 1^2 + 2^2 = 1 + 4 = 5. Porta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.puzzle_attempts += 1;
            if (global.puzzle_attempts == 1) {
                global.dialogue_text = "QUADRO - Funcoes de varias variaveis\n\nAnotacoes:\n- Em f(1,2), x vale 1 e y vale 2.\n- Depois da substituicao, calcule as potencias.\n\nDica: substitua x por 1 e y por 2.\n\nf(x,y) = x^2 + y^2\nQuanto vale f(1,2)?";
            } else if (global.puzzle_attempts == 2) {
                global.dialogue_text = "QUADRO - Funcoes de varias variaveis\n\nAnotacoes:\n- f(1,2) = 1^2 + 2^2.\n- 1^2 vale 1.\n- 2^2 vale 4.\n\nAgora falta somar os resultados.";
            } else {
                global.dialogue_text = "Tutor: 1^2 = 1 e 2^2 = 4. Somando, 1 + 4 = 5. Aperte 2 para confirmar.";
            }
            global.dialogue_text += "\n\n1) 3\n2) 5\n3) 8";
            global.dialogue_timer = -1;
        }
    }

    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter)) {
        global.input_mode = "none";
        global.dialogue_text = "";
        global.dialogue_timer = 0;
    }
}

if (global.input_mode == "puzzle_lab_02") {
    var answer2 = 0;
    if (keyboard_check_pressed(ord("1"))) answer2 = 1;
    if (keyboard_check_pressed(ord("2"))) answer2 = 2;
    if (keyboard_check_pressed(ord("3"))) answer2 = 3;

    var correct2 = global.hard_mode ? 3 : 2;

    if (answer2 != 0) {
        if (answer2 == correct2) {
            global.lab_02_puzzle_solved = true;
            global.input_mode = "none";

            if (global.hard_mode) {
                global.dialogue_text = "Correto! df/dy = x^2 + 8y. No ponto (2,1), isso fica 4 + 8 = 12. Porta liberada.";
            } else {
                global.dialogue_text = "Correto! Para df/dx, o termo 3y fica constante. A derivada de x^2 e 2x. No ponto (2,1), isso vale 4. Porta liberada.";
            }
            global.dialogue_timer = -1;
        } else {
            global.puzzle_attempts_lab_02 += 1;

            if (global.hard_mode) {
                if (global.puzzle_attempts_lab_02 == 1) {
                    global.dialogue_text = "QUADRO - Derivadas parciais\n\nA pergunta e sobre y. Trate x como constante.\n\nf(x,y) = x^2*y + 4y^2\nQual e df/dy no ponto (2,1)?\n\n1) 8\n2) 10\n3) 12";
                } else {
                    global.dialogue_text = "Tutor: Em df/dy, x^2*y vira x^2, e 4y^2 vira 8y. Depois substitua x=2 e y=1.\n\n1) 8\n2) 10\n3) 12";
                }
            } else {
                if (global.puzzle_attempts_lab_02 == 1) {
                    global.dialogue_text = "QUADRO - Derivadas parciais\n\nDica:\nA pergunta e sobre x. Olhe so para os termos que mudam quando x muda.\n\nf(x,y) = x^2 + 3y\nQual e df/dx no ponto (2,1)?\n\n1) 3\n2) 4\n3) 7";
                } else if (global.puzzle_attempts_lab_02 == 2) {
                    global.dialogue_text = "QUADRO - Derivadas parciais\n\nEm df/dx, o termo 3y fica constante. Entao voce deriva apenas x^2.\nA derivada de x^2 e 2x.\n\n1) 3\n2) 4\n3) 7";
                } else {
                    global.dialogue_text = "Tutor: A derivada de x^2 e 2x. Como o ponto e (2,1), use x=2. Entao 2*2 = 4.\n\n1) 3\n2) 4\n3) 7";
                }
            }
            global.dialogue_timer = -1;
        }
    }

    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter)) {
        global.input_mode = "none";
        global.dialogue_text = "";
        global.dialogue_timer = 0;
    }
}


if (global.input_mode == "puzzle_lab_03") {
    var answer3 = 0;
    if (keyboard_check_pressed(ord("1"))) answer3 = 1;
    if (keyboard_check_pressed(ord("2"))) answer3 = 2;
    if (keyboard_check_pressed(ord("3"))) answer3 = 3;

    var correct3 = global.hard_mode ? 2 : 1;

    if (answer3 != 0) {
        if (answer3 == correct3) {
            global.lab_03_puzzle_solved = true;
            global.input_mode = "none";

            if (global.hard_mode) {
                global.dialogue_text = "Correto! df/dx = 4x + y e df/dy = x. No ponto (1,2), grad f = (6,1). A passagem esta liberada.";
            } else {
                global.dialogue_text = "Correto! df/dx = 2x e df/dy = 2y. No ponto (1,2), grad f = (2,4). A passagem esta liberada.";
            }
            global.dialogue_timer = -1;
        } else {
            global.puzzle_attempts_lab_03 += 1;

            if (global.hard_mode) {
                if (global.puzzle_attempts_lab_03 == 1) {
                    global.dialogue_text = "MESA CARTOGRAFICA - Vetor gradiente\n\nA pergunta pede o vetor inteiro. Calcule df/dx e df/dy antes de substituir o ponto.\n\nf(x,y) = 2x^2 + xy\nNo ponto (1,2), qual e grad f?\n\n1) (4,2)\n2) (6,1)\n3) (2,6)";
                } else {
                    global.dialogue_text = "Tutor: Para f(x,y) = 2x^2 + xy, df/dx = 4x + y e df/dy = x. Depois use x=1 e y=2.\n\n1) (4,2)\n2) (6,1)\n3) (2,6)";
                }
            } else {
                if (global.puzzle_attempts_lab_03 == 1) {
                    global.dialogue_text = "MESA CARTOGRAFICA - Vetor gradiente\n\nDica:\nO gradiente tem duas partes. Para f(x,y) = x^2 + y^2, calcule uma derivada em x e outra em y.\n\n1) (2,4)\n2) (1,2)\n3) (4,2)";
                } else if (global.puzzle_attempts_lab_03 == 2) {
                    global.dialogue_text = "MESA CARTOGRAFICA - Vetor gradiente\n\ndf/dx = 2x e df/dy = 2y. No ponto (1,2), use x=1 e y=2.\n\n1) (2,4)\n2) (1,2)\n3) (4,2)";
                } else {
                    global.dialogue_text = "Tutor: O primeiro valor do gradiente vem de df/dx: 2*1 = 2. O segundo vem de df/dy: 2*2 = 4. Entao o vetor e (2,4).\n\n1) (2,4)\n2) (1,2)\n3) (4,2)";
                }
            }
            global.dialogue_timer = -1;
        }
    }

    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter)) {
        global.input_mode = "none";
        global.dialogue_text = "";
        global.dialogue_timer = 0;
    }
}
