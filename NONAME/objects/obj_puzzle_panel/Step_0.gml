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
                global.dialogue_text = "Dica 1: substitua x por 1 e y por 2. Nao precisa mudar a formula inteira.";
            } else if (global.puzzle_attempts == 2) {
                global.dialogue_text = "Dica 2: f(1,2) = 1^2 + 2^2. Primeiro calcule as potencias.";
            } else {
                global.dialogue_text = "Tutor: 1^2 = 1 e 2^2 = 4. Somando, 1 + 4 = 5. Aperte 2 para confirmar.";
            }
            global.dialogue_text += "\n\n1) 3\n2) 5\n3) 8";
            global.dialogue_timer = -1;
        }
    }

    if (keyboard_check_pressed(vk_escape)) {
        global.input_mode = "none";
        global.dialogue_text = "Voce saiu do painel. Pode tentar de novo com E.";
        global.dialogue_timer = 140;
    }
}
