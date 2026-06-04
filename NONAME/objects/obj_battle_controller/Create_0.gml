// Controlador de batalha padronizado.
// Ele escolhe os dados da batalha a partir da room atual ou de global.current_battle.

if (!variable_global_exists("difficulty_mode")) global.difficulty_mode = "learning";
if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = -1;
if (!variable_global_exists("notebook_pages")) global.notebook_pages = [];
if (!variable_global_exists("item_cereal_bars")) global.item_cereal_bars = 0;
if (!variable_global_exists("item_apples")) global.item_apples = 0;
if (!variable_global_exists("notebook_monitor_sem_rosto")) global.notebook_monitor_sem_rosto = false;
if (!variable_global_exists("notebook_aluna_janela")) global.notebook_aluna_janela = false;
if (!variable_global_exists("notebook_cartografo")) global.notebook_cartografo = false;
if (!variable_global_exists("notebook_isiaha")) global.notebook_isiaha = false;
if (!variable_global_exists("booly_unlocked")) global.booly_unlocked = false;
if (!variable_global_exists("booly_completed")) global.booly_completed = false;
if (!variable_global_exists("booly_reward_apples")) global.booly_reward_apples = false;
if (!variable_global_exists("reward_monitor_items")) global.reward_monitor_items = false;
if (!variable_global_exists("hp_bonus_after_cartografo")) global.hp_bonus_after_cartografo = false;
if (!variable_global_exists("hp_bonus_after_isiaha")) global.hp_bonus_after_isiaha = false;
if (!variable_global_exists("last_room_before_battle")) global.last_room_before_battle = rm_lab_01;

if (!variable_global_exists("current_battle")) {
    global.current_battle = (room == rm_battle_booly) ? "booly" : ((room == rm_battle_04) ? "isiaha" : ((room == rm_battle_03) ? "cartografo" : ((room == rm_battle_02) ? "aluna" : "monitor")));
}

if (room == rm_battle_booly) {
    global.current_battle = "booly";
} else if (room == rm_battle_04) {
    global.current_battle = "isiaha";
} else if (room == rm_battle_03) {
    global.current_battle = "cartografo";
} else if (room == rm_battle_02) {
    global.current_battle = "aluna";
} else if (room == rm_battle_01) {
    global.current_battle = "monitor";
}

battle_id = global.current_battle;

if (!variable_global_exists("battle_music")) global.battle_music = noone;
if (variable_global_exists("background_music") && global.background_music != noone) {
    audio_stop_sound(global.background_music);
    global.background_music = noone;
}
if (global.battle_music == noone) {
    var battle_theme = snd_battle_theme;
    if (battle_id == "aluna") battle_theme = snd_battle_theme_02;
    else if (battle_id == "cartografo") battle_theme = snd_battle_theme_03;
    else if (battle_id == "isiaha") battle_theme = snd_battle_theme_04;
    else if (battle_id == "booly") battle_theme = snd_battle_theme_booly;
    global.battle_music = audio_play_sound(battle_theme, 10, true);
}

randomize();

// Dados do jogador. A vida e restaurada ao entrar em cada batalha por enquanto.
if (!variable_global_exists("player_max_hp")) global.player_max_hp = 30;
if (!variable_global_exists("hp_bonus_after_monitor")) global.hp_bonus_after_monitor = false;
global.player_hp = global.player_max_hp;
player_hp = global.player_hp;
max_player_hp = global.player_max_hp;

// Dados visuais do jogador em todas as batalhas.
player_battle_sprite = sprite_player_battle;
player_battle_scale = 0.48;
player_battle_x = 260;
player_battle_y = 590;

mode_label = (global.difficulty_mode == "booly") ? "Modo Booly" : (global.hard_mode ? "Modo Dificil" : "Modo Aprendizado");

// Configuracoes especificas por batalha.

if (battle_id == "booly") {
    battle_number_label = "Batalha secreta";
    battle_concept_label = "Revisao geral";
    battle_background_sprite = sprite_battle_room_booly;
    victory_room = rm_end;
    reset_room = rm_lab_booly;

    enemy_name = "Booly";
    enemy_hp = 96;
    max_enemy_hp = enemy_hp;
    enemy_damage_min = 7;
    enemy_damage_max = 12;
    player_attack_damage = 7;
    enemy_battle_sprite = sprite_booly_battle;
    enemy_dialogue_sprite = sprite_booly_dialogue;
    enemy_battle_scale = 0.54;
    enemy_battle_x = room_width - 320;
    enemy_battle_y = 590;

    isiaha_phase = 1;
    isiaha_special_damage_min = 12;
    isiaha_special_damage_max = 17;
    isiaha_special_reward_damage = 8;

    review_text = "Eu: Revisao geral. Funcao: substituir x e y. Parcial: uma variavel muda e a outra fica parada. Gradiente: (df/dx, df/dy). Hessiana: classifica pontos criticos.";

    intro_lines = [
        "Booly: Eu sabia que voce voltaria.",
        "Eu: Voce sabia?",
        "Booly: Nao. Mas eu queria comecar assim.",
        "Tutor: Essa sala tem material de todas as outras.",
        "Booly: Exato. Eu tenho todas as apostilas. Algumas ate estao do lado certo.",
        "Eu: Voce estudou?",
        "Booly: Eu carreguei. Hoje vamos descobrir se isso conta."
    ];

    question_bank_learning = [
        { prompt: "Apostila de funcoes\nf(x,y) = x^2 + y\nQuanto vale f(2,3)?", options: ["1) 5", "2) 7", "3) 9"], correct: 2, solution: "f(2,3) = 2^2 + 3 = 4 + 3 = 7.", hint: "Substitua x por 2 e y por 3.", wrong: "Booly misturou as folhas, mas essa era substituicao direta." },
        { prompt: "Apostila de derivadas parciais\nf(x,y) = xy + y^2\nQual e df/dx no ponto (3,2)?", options: ["1) 2", "2) 3", "3) 7"], correct: 1, solution: "Em df/dx, y fica constante. A derivada de xy em relacao a x e y. No ponto, y = 2.", hint: "Para df/dx, trate y como constante.", wrong: "Essa pergunta era de derivada parcial em x." },
        { prompt: "Apostila de gradiente\nf(x,y) = x^2 + y^2\nNo ponto (1,2), qual e grad f?", options: ["1) (2,4)", "2) (1,2)", "3) (4,2)"], correct: 1, solution: "df/dx = 2x e df/dy = 2y. No ponto (1,2), grad f = (2,4).", hint: "O gradiente junta df/dx e df/dy.", wrong: "Essa era uma pergunta de vetor gradiente." },
        { prompt: "Apostila de Hessiana\nH = [ 2  0 ]\n    [ 0 -2 ]\nComo classificar?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "Uma direcao tem curvatura positiva e a outra negativa. O ponto e de sela.", hint: "Sinais opostos indicam ponto de sela.", wrong: "Essa era classificacao por Hessiana." }
    ];

    question_bank_hard = [
        { prompt: "Apostila misturada\nf(x,y) = x^2 - y^2 + xy\nQuanto vale f(2,1)?", options: ["1) 3", "2) 5", "3) 7"], correct: 2, solution: "f(2,1) = 4 - 1 + 2 = 5.", hint: "", wrong: "Comece identificando se a pergunta pede valor, derivada, gradiente ou classificacao." },
        { prompt: "Apostila misturada\nf(x,y) = x^2*y + 4y^2\nQual e df/dy no ponto (2,1)?", options: ["1) 8", "2) 10", "3) 12"], correct: 3, solution: "df/dy = x^2 + 8y. No ponto (2,1), fica 4 + 8 = 12.", hint: "", wrong: "Era derivada parcial em y. x fica constante." },
        { prompt: "Apostila misturada\nf(x,y) = 2x^2 + xy\nNo ponto (1,2), qual e grad f?", options: ["1) (4,2)", "2) (6,1)", "3) (2,6)"], correct: 2, solution: "df/dx = 4x + y e df/dy = x. No ponto (1,2), grad f = (6,1).", hint: "", wrong: "Essa era de gradiente: calcule as duas parciais." },
        { prompt: "Apostila misturada\nfxx = -4, fyy = -3, fxy = 2\nD = 8. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 2, solution: "D > 0 e fxx < 0. O ponto e maximo local.", hint: "", wrong: "D positivo pede o sinal de fxx. fxx negativo indica maximo." },
        { prompt: "Apostila misturada\nfxx = 5, fyy = -1, fxy = 2\nD = -9. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "D < 0. O ponto e de sela.", hint: "", wrong: "D negativo indica sela." }
    ];

    hessian_special_learning = [
        { prompt: "Prova surpresa do Booly\n\nEle abriu tres apostilas ao mesmo tempo.\nf(x,y) = xy + y^2\nQual e df/dy no ponto (2,3)?", options: ["1) 5", "2) 8", "3) 9"], correct: 2, solution: "df/dy = x + 2y. No ponto (2,3), fica 2 + 6 = 8.", wrong: "Booly jogou apostilas demais. Era uma derivada parcial em y." },
        { prompt: "Prova surpresa do Booly\n\nf(x,y) = x^2 + y^2\nPonto (2,1). Qual e grad f?", options: ["1) (4,2)", "2) (2,4)", "3) (4,1)"], correct: 1, solution: "grad f = (2x, 2y). No ponto (2,1), fica (4,2).", wrong: "Era gradiente: duas derivadas parciais formando um vetor." }
    ];

    hessian_special_hard = [
        { prompt: "Prova surpresa do Booly\n\nf(x,y) = 3xy^2 + x\nQual e df/dx no ponto (2,2)?", options: ["1) 12", "2) 13", "3) 16"], correct: 2, solution: "df/dx = 3y^2 + 1. No ponto (2,2), fica 12 + 1 = 13.", wrong: "Era parcial em x. O y ficava parado." },
        { prompt: "Prova surpresa do Booly\n\nfxx = 2, fyy = -5, fxy = 1\nD = -11. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "D < 0, entao o ponto e de sela.", wrong: "D negativo significa ponto de sela." }
    ];

    notebook_page_title = "Desafio geral do Booly";
    notebook_page_body = "Booly mistura todos os assuntos: funcoes de varias variaveis, derivadas parciais, gradiente e Hessiana. Para sobreviver ao desafio, primeiro identifique o tipo de pergunta. Se pedir valor, substitua o par. Se pedir parcial, mantenha uma variavel constante. Se pedir gradiente, junte as duas parciais. Se pedir Hessiana, classifique o ponto critico pelo teste da segunda derivada.";
}
else if (battle_id == "isiaha") {
    battle_number_label = "Batalha 04";
    battle_concept_label = "Maximos, minimos e Hessiana";
    battle_background_sprite = sprite_battle_room_04;
    victory_room = rm_end;
    reset_room = rm_lab_04;

    enemy_name = "Isiaha";
    enemy_hp = global.hard_mode ? 58 : 38;
    max_enemy_hp = enemy_hp;
    enemy_damage_min = global.hard_mode ? 8 : 4;
    enemy_damage_max = global.hard_mode ? 12 : 6;
    player_attack_damage = global.hard_mode ? 7 : 8;
    enemy_battle_sprite = sprite_isiaha_battle;
    enemy_dialogue_sprite_phase1 = sprite_isiaha_dialogue_01;
    enemy_dialogue_sprite_phase2 = sprite_isiaha_dialogue_02;
    enemy_dialogue_sprite = enemy_dialogue_sprite_phase1;
    enemy_battle_scale = 0.50;
    enemy_battle_x = room_width - 330;
    enemy_battle_y = 590;

    isiaha_phase = 1;
    isiaha_phase_threshold = max_enemy_hp * 0.5;
    isiaha_special_damage_min = global.hard_mode ? 12 : 7;
    isiaha_special_damage_max = global.hard_mode ? 16 : 10;
    isiaha_special_reward_damage = global.hard_mode ? 5 : 6;

    if (global.hard_mode) {
        review_text = "Eu: Revisao rapida. Ponto critico: df/dx = 0 e df/dy = 0. Hessiana: D = fxx*fyy - (fxy)^2.";
    } else {
        review_text = "Eu: Vou revisar. Primeiro encontro o ponto critico. Depois olho a Hessiana: se as duas curvaturas sobem, minimo; se descem, maximo; se uma sobe e outra desce, sela.";
    }

    intro_lines = [
        "Isiaha: Voce passou por tres salas.",
        "Eu: Voce estava esperando aqui?",
        "Isiaha: Eu estava observando. Tem diferenca.",
        "Tutor: A cobra... ela esta seguindo as linhas do chao.",
        "Isiaha: Ela reconhece curvatura melhor que muita gente. E ela nao gosta de chute.",
        "Isiaha: Se chegou ate aqui, entao classifique direito. Um ponto parado ainda pode esconder muita coisa."
    ];

    question_bank_learning = [
        { prompt: "f(x,y) = x^2 + y^2\nQual e o ponto critico?", options: ["1) (0,0)", "2) (1,1)", "3) (2,0)"], correct: 1, solution: "df/dx = 2x e df/dy = 2y. As duas zeram em (0,0).", hint: "Procure onde as duas derivadas parciais valem zero ao mesmo tempo.", wrong: "O ponto critico precisa zerar as duas derivadas parciais." },
        { prompt: "H = [ 2  0 ]\n    [ 0  2 ]\nComo classificar o ponto?", options: ["1) Maximo local", "2) Minimo local", "3) Ponto de sela"], correct: 2, solution: "As duas direcoes tem curvatura positiva. O ponto e minimo local.", hint: "Curvatura positiva nas duas direcoes lembra o fundo de uma tigela.", wrong: "Quando a Hessiana aponta para cima nas duas direcoes, a classificacao e minimo." },
        { prompt: "H = [ -2  0 ]\n    [  0 -2 ]\nComo classificar o ponto?", options: ["1) Maximo local", "2) Minimo local", "3) Ponto de sela"], correct: 1, solution: "As duas direcoes tem curvatura negativa. O ponto e maximo local.", hint: "Curvatura negativa nas duas direcoes lembra o topo de uma montanha.", wrong: "Se as duas direcoes descem a partir do ponto, ele e um maximo local." },
        { prompt: "H = [ 2  0 ]\n    [ 0 -2 ]\nComo classificar o ponto?", options: ["1) Maximo local", "2) Minimo local", "3) Ponto de sela"], correct: 3, solution: "Uma direcao sobe e outra desce. O ponto e de sela.", hint: "Sinais opostos indicam comportamentos diferentes ao redor do mesmo ponto.", wrong: "Se uma direcao sobe e outra desce, nao e maximo nem minimo: e sela." }
    ];

    question_bank_learning_phase2 = [
        { prompt: "D = fxx*fyy - (fxy)^2\nfxx = 2, fyy = 2, fxy = 0\nQual e a classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 1, solution: "D = 2*2 - 0 = 4. Como D > 0 e fxx > 0, e minimo local.", hint: "Quando D > 0, olhe o sinal de fxx. Se fxx > 0, minimo.", wrong: "D positivo com fxx positivo indica minimo local." },
        { prompt: "D = fxx*fyy - (fxy)^2\nfxx = -2, fyy = -3, fxy = 0\nQual e a classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 2, solution: "D = (-2)*(-3) - 0 = 6. Como D > 0 e fxx < 0, e maximo local.", hint: "D > 0 com fxx negativo indica maximo local.", wrong: "D positivo e fxx negativo indicam maximo local." },
        { prompt: "D = fxx*fyy - (fxy)^2\nfxx = 2, fyy = -2, fxy = 0\nQual e a classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "D = 2*(-2) - 0 = -4. Como D < 0, e ponto de sela.", hint: "Quando D < 0, a classificacao e ponto de sela.", wrong: "D negativo indica ponto de sela." }
    ];

    question_bank_hard = [
        { prompt: "fxx = 4, fyy = 2, fxy = 0\nD = 8 e fxx > 0. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 1, solution: "D > 0 e fxx > 0. O ponto e minimo local.", hint: "", wrong: "Com D positivo, o sinal de fxx decide entre minimo e maximo." },
        { prompt: "fxx = -3, fyy = -2, fxy = 0\nD = 6 e fxx < 0. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 2, solution: "D > 0 e fxx < 0. O ponto e maximo local.", hint: "", wrong: "D positivo com fxx negativo indica maximo." },
        { prompt: "fxx = 2, fyy = -5, fxy = 1\nD = -11. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "D < 0. O ponto e de sela.", hint: "", wrong: "Quando D e negativo, nao precisa olhar fxx: e sela." }
    ];

    question_bank_hard_phase2 = [
        { prompt: "fxx = 3, fyy = 3, fxy = 1\nD = 8. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 1, solution: "D = 8 > 0 e fxx = 3 > 0. O ponto e minimo local.", hint: "", wrong: "D > 0 pede o sinal de fxx. Positivo indica minimo." },
        { prompt: "fxx = -4, fyy = -3, fxy = 2\nD = 8. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 2, solution: "D = 8 > 0 e fxx = -4 < 0. O ponto e maximo local.", hint: "", wrong: "D > 0 e fxx negativo indicam maximo local." },
        { prompt: "fxx = 5, fyy = -1, fxy = 2\nD = -9. Classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "D = -9 < 0. O ponto e de sela.", hint: "", wrong: "D negativo sempre indica ponto de sela no teste da segunda derivada." }
    ];

    hessian_special_learning = [
        { prompt: "Julgamento da Hessiana\n\nfxx = 2, fyy = -2, fxy = 0\nD = 2*(-2) - 0^2\nQual e a classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "D = -4. Como D < 0, a resposta e ponto de sela.", wrong: "A cobra atacou porque D ficou negativo. Isso indicava sela." },
        { prompt: "Julgamento da Hessiana\n\nfxx = 3, fyy = 2, fxy = 0\nD = 3*2 - 0^2\nQual e a classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 1, solution: "D = 6 e fxx > 0. A resposta e minimo local.", wrong: "D era positivo e fxx tambem. Isso indicava minimo." }
    ];

    hessian_special_hard = [
        { prompt: "Julgamento da Hessiana\n\nfxx = -4, fyy = -3, fxy = 2\nD = (-4)*(-3) - 2^2\nQual e a classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 2, solution: "D = 12 - 4 = 8. Como D > 0 e fxx < 0, e maximo local.", wrong: "D ficou positivo, mas fxx era negativo. Isso indicava maximo local." },
        { prompt: "Julgamento da Hessiana\n\nfxx = 2, fyy = -5, fxy = 1\nD = 2*(-5) - 1^2\nQual e a classificacao?", options: ["1) Minimo local", "2) Maximo local", "3) Ponto de sela"], correct: 3, solution: "D = -10 - 1 = -11. Como D < 0, e ponto de sela.", wrong: "D era negativo. O teste indicava ponto de sela." }
    ];

    notebook_page_title = "Maximos, minimos e Hessiana";
    notebook_page_body = "Um ponto critico ocorre quando as derivadas parciais de primeira ordem sao zero. A matriz Hessiana reune as derivadas de segunda ordem: fxx, fxy, fyx e fyy. Para duas variaveis, usamos D = fxx*fyy - (fxy)^2. Se D > 0 e fxx > 0, temos minimo local. Se D > 0 e fxx < 0, temos maximo local. Se D < 0, temos ponto de sela. Se D = 0, o teste e inconclusivo.";
}
else if (battle_id == "cartografo") {
    battle_number_label = "Batalha 03";
    battle_concept_label = "Vetor gradiente";
    battle_background_sprite = sprite_battle_room_03;
    victory_room = rm_lab_04;
    reset_room = rm_lab_03;

    enemy_name = "Cartografo";
    enemy_hp = global.hard_mode ? 42 : 26;
    max_enemy_hp = enemy_hp;
    enemy_damage_min = global.hard_mode ? 7 : 3;
    enemy_damage_max = global.hard_mode ? 11 : 5;
    player_attack_damage = global.hard_mode ? 7 : 8;
    enemy_battle_sprite = sprite_cartografo_battle;
    enemy_dialogue_sprite = sprite_cartografo_dialogue;
    enemy_battle_scale = 0.50;
    enemy_battle_x = room_width - 310;
    enemy_battle_y = 590;

    if (global.hard_mode) {
        review_text = "Eu: Revisao rapida. O gradiente e (df/dx, df/dy). Calculo as derivadas parciais e substituo o ponto.";
    } else {
        review_text = "Eu: Vou revisar. O gradiente junta df/dx e df/dy em um vetor. Esse vetor aponta para onde a funcao cresce mais rapido.";
    }

    intro_lines = [
        "Cartografo: Finalmente. Um ponto com pernas.",
        "Eu: Voce e o dono desses mapas?",
        "Cartografo: Dono nao. Curador das rotas, admirador das setas, fiscal de curvas mal desenhadas.",
        "Tutor: Ele esta falando do gradiente.",
        "Cartografo: Estou falando de direcao. O mundo inteiro melhora quando alguem aponta direito.",
        "Cartografo: Vamos ver se voce sabe para onde uma funcao quer crescer."
    ];

    question_bank_learning = [
        {
            prompt: "f(x,y) = x^2 + y^2\nNo ponto (1,2), qual e grad f?",
            options: ["1) (2,4)", "2) (1,2)", "3) (4,2)"],
            correct: 1,
            solution: "df/dx = 2x e df/dy = 2y. No ponto (1,2), grad f = (2,4).",
            hint: "Calcule uma derivada em x e outra em y. Depois junte os dois resultados no vetor.",
            wrong: "O vetor precisa ter duas componentes: a primeira vem de df/dx e a segunda de df/dy."
        },
        {
            prompt: "f(x,y) = 2x + y^2\nNo ponto (1,3), qual e grad f?",
            options: ["1) (6,2)", "2) (2,6)", "3) (3,2)"],
            correct: 2,
            solution: "df/dx = 2 e df/dy = 2y. No ponto (1,3), grad f = (2,6).",
            hint: "O termo 2x gera a componente em x. O termo y^2 gera a componente em y.",
            wrong: "Lembre da ordem do gradiente: primeiro df/dx, depois df/dy."
        },
        {
            prompt: "f(x,y) = xy\nNo ponto (3,2), qual e grad f?",
            options: ["1) (3,2)", "2) (5,5)", "3) (2,3)"],
            correct: 3,
            solution: "df/dx = y e df/dy = x. No ponto (3,2), grad f = (2,3).",
            hint: "Em xy, a derivada em x vira y, e a derivada em y vira x.",
            wrong: "Cuidado para nao inverter o ponto com o vetor. O gradiente usa as derivadas."
        },
        {
            prompt: "f(x,y) = x^2 + 3y\nNo ponto (2,1), qual e grad f?",
            options: ["1) (3,4)", "2) (4,3)", "3) (2,3)"],
            correct: 2,
            solution: "df/dx = 2x e df/dy = 3. No ponto (2,1), grad f = (4,3).",
            hint: "A derivada de 3y em relacao a y e 3. A derivada de x^2 em relacao a x e 2x.",
            wrong: "Calcule as duas parciais separadamente e mantenha a ordem (df/dx, df/dy)."
        }
    ];

    question_bank_hard = [
        {
            prompt: "f(x,y) = 2x^2 + xy\nNo ponto (1,2), qual e grad f?",
            options: ["1) (4,2)", "2) (6,1)", "3) (2,6)"],
            correct: 2,
            solution: "df/dx = 4x + y e df/dy = x. No ponto (1,2), grad f = (6,1).",
            hint: "",
            wrong: "O termo xy contribui para as duas derivadas parciais."
        },
        {
            prompt: "f(x,y) = x^2*y + y^2\nNo ponto (2,1), qual e grad f?",
            options: ["1) (4,6)", "2) (6,4)", "3) (8,5)"],
            correct: 1,
            solution: "df/dx = 2xy e df/dy = x^2 + 2y. No ponto (2,1), grad f = (4,6).",
            hint: "",
            wrong: "Em df/dy, o termo x^2*y vira x^2."
        },
        {
            prompt: "f(x,y) = x^3 + 2xy\nNo ponto (1,4), qual e grad f?",
            options: ["1) (7,2)", "2) (9,4)", "3) (11,2)"],
            correct: 3,
            solution: "df/dx = 3x^2 + 2y e df/dy = 2x. No ponto (1,4), grad f = (11,2).",
            hint: "",
            wrong: "Nao esqueca que 2xy tambem entra em df/dx."
        },
        {
            prompt: "f(x,y) = 3xy + y^2\nNo ponto (2,3), qual e grad f?",
            options: ["1) (9,12)", "2) (12,9)", "3) (6,9)"],
            correct: 1,
            solution: "df/dx = 3y e df/dy = 3x + 2y. No ponto (2,3), grad f = (9,12).",
            hint: "",
            wrong: "Calcule df/dx e df/dy antes de substituir o ponto."
        }
    ];

    notebook_page_title = "Vetor gradiente";
    notebook_page_body = "O vetor gradiente junta as derivadas parciais de uma funcao. Para uma funcao f(x,y), usamos grad f = (df/dx, df/dy). Geometricamente, esse vetor aponta para a direcao em que a funcao cresce mais rapido. Exemplo: se f(x,y) = x^2 + y^2, entao grad f = (2x, 2y). No ponto (1,2), o gradiente e (2,4).";
}
else if (battle_id == "aluna") {
    battle_number_label = "Batalha 02";
    battle_concept_label = "Derivadas parciais";
    battle_background_sprite = sprite_battle_room_02;
    victory_room = rm_lab_03;
    reset_room = rm_lab_02;

    enemy_name = "Aluna da Janela";
    enemy_hp = global.hard_mode ? 34 : 20;
    max_enemy_hp = enemy_hp;
    enemy_damage_min = global.hard_mode ? 6 : 2;
    enemy_damage_max = global.hard_mode ? 10 : 4;
    player_attack_damage = global.hard_mode ? 7 : 8;
    enemy_battle_sprite = sprite_aluna_battle;
    enemy_dialogue_sprite = sprite_aluna_dialogue;
    enemy_battle_scale = 0.50;
    enemy_battle_x = room_width - 300;
    enemy_battle_y = 590;

    if (global.hard_mode) {
        review_text = "Eu: Revisao rapida. Em df/dx, y fica constante. Em df/dy, x fica constante. Depois substitui o ponto.";
    } else {
        review_text = "Eu: Vou revisar. Derivada parcial mede como a funcao muda quando apenas uma variavel muda. Em df/dx, y fica parado. Em df/dy, x fica parado.";
    }

    intro_lines = [
        "Aluna da Janela: Voce abriu a porta tambem.",
        "Eu: Voce estava esperando aqui?",
        "Aluna da Janela: Eu fiquei tentando sair. Toda vez que mexo em uma coisa, parece que o resto muda junto.",
        "Eu: O tutor disse para manter uma variavel parada.",
        "Aluna da Janela: Entao mostra. Eu preciso ver uma coisa mudar sozinha."
    ];

    question_bank_learning = [
        {
            prompt: "f(x,y) = x^2 + 3y\nQual e df/dx no ponto (2,1)?",
            options: ["1) 3", "2) 4", "3) 7"],
            correct: 2,
            solution: "Em df/dx, 3y fica constante. A derivada de x^2 e 2x. No ponto (2,1), 2*2 = 4.",
            hint: "A pergunta e sobre x. Trate y como constante e derive apenas o que muda com x.",
            wrong: "Tente separar as variaveis. Para df/dx, o y nao muda."
        },
        {
            prompt: "f(x,y) = 2x + y^2\nQual e df/dy no ponto (1,3)?",
            options: ["1) 2", "2) 3", "3) 6"],
            correct: 3,
            solution: "Em df/dy, 2x fica constante. A derivada de y^2 e 2y. No ponto (1,3), 2*3 = 6.",
            hint: "A pergunta e sobre y. O termo 2x fica constante.",
            wrong: "Para df/dy, olhe para os termos que mudam quando y muda."
        },
        {
            prompt: "f(x,y) = xy + 5\nQual e df/dx no ponto (3,2)?",
            options: ["1) 2", "2) 3", "3) 5"],
            correct: 1,
            solution: "Em df/dx, y fica constante. A derivada de xy em relacao a x e y. No ponto (3,2), y = 2.",
            hint: "Em xy, quando x muda e y fica parado, a derivada vira y.",
            wrong: "Nao use o x nesse caso. Para df/dx de xy, o resultado e y."
        },
        {
            prompt: "f(x,y) = xy + 5\nQual e df/dy no ponto (3,2)?",
            options: ["1) 2", "2) 3", "3) 5"],
            correct: 2,
            solution: "Em df/dy, x fica constante. A derivada de xy em relacao a y e x. No ponto (3,2), x = 3.",
            hint: "Em xy, quando y muda e x fica parado, a derivada vira x.",
            wrong: "Para df/dy de xy, o resultado e x. Depois use o valor do ponto."
        }
    ];

    question_bank_hard = [
        {
            prompt: "f(x,y) = x^2*y + 4y^2\nQual e df/dy no ponto (2,1)?",
            options: ["1) 8", "2) 10", "3) 12"],
            correct: 3,
            solution: "df/dy = x^2 + 8y. No ponto (2,1), isso fica 4 + 8 = 12.",
            hint: "",
            wrong: "Em df/dy, x fica constante. Derive os termos em y."
        },
        {
            prompt: "f(x,y) = 3xy^2 + x\nQual e df/dx no ponto (2,2)?",
            options: ["1) 12", "2) 13", "3) 16"],
            correct: 2,
            solution: "df/dx = 3y^2 + 1. No ponto (2,2), isso fica 3*4 + 1 = 13.",
            hint: "",
            wrong: "Para df/dx, trate y como constante."
        },
        {
            prompt: "f(x,y) = x^3 + 2xy\nQual e df/dx no ponto (1,4)?",
            options: ["1) 7", "2) 9", "3) 11"],
            correct: 3,
            solution: "df/dx = 3x^2 + 2y. No ponto (1,4), isso fica 3 + 8 = 11.",
            hint: "",
            wrong: "Nao esqueca de derivar 2xy em relacao a x."
        },
        {
            prompt: "f(x,y) = x^2*y - y^3\nQual e df/dy no ponto (3,1)?",
            options: ["1) 3", "2) 6", "3) 9"],
            correct: 2,
            solution: "df/dy = x^2 - 3y^2. No ponto (3,1), isso fica 9 - 3 = 6.",
            hint: "",
            wrong: "Cuidado com o termo -y^3. Ele vira -3y^2."
        }
    ];

    notebook_page_title = "Derivadas parciais";
    notebook_page_body = "Uma derivada parcial mede como uma funcao de varias variaveis muda quando apenas uma variavel varia. Para calcular df/dx, tratamos y como constante. Para calcular df/dy, tratamos x como constante. Exemplo: se f(x,y) = x^2 + 3y, entao df/dx = 2x e df/dy = 3.";
}
else {
    battle_number_label = "Batalha 01";
    battle_concept_label = "Funcoes de varias variaveis";
    battle_background_sprite = sprite_battle_room_01;
    victory_room = rm_lab_02;
    reset_room = rm_lab_01;

    enemy_name = "Monitor Sem Rosto";
    enemy_hp = global.hard_mode ? 30 : 12;
    max_enemy_hp = enemy_hp;
    enemy_damage_min = global.hard_mode ? 5 : 1;
    enemy_damage_max = global.hard_mode ? 9 : 2;
    player_attack_damage = global.hard_mode ? 7 : 8;
    enemy_battle_sprite = sprite_msr_battle;
    enemy_dialogue_sprite = sprite_msr_dialogue;
    enemy_battle_scale = 0.50;
    enemy_battle_x = room_width - 300;
    enemy_battle_y = 590;

    if (global.hard_mode) {
        review_text = "Eu: Revisao rapida. Uma funcao de duas variaveis recebe um par ordenado. Para calcular f(x,y), os dois valores entram na expressao.";
    } else {
        review_text = "Eu: Vou revisar com calma. A funcao recebe dois valores, x e y. Para calcular f(1,2), eu substituo x por 1, y por 2, e so depois faco as contas.";
    }

    intro_lines = [
        "Monitor Sem Rosto: Voce abriu a porta.",
        "Eu: Quem e voce?",
        "Monitor Sem Rosto: Eu fico onde as salas acabam. Nao lembro quando comecei.",
        "Eu: Voce tambem esta preso aqui?",
        "Monitor Sem Rosto: Talvez. Por enquanto, eu so verifico quem tenta passar.",
        "Monitor Sem Rosto: O quadro te deu uma regra. Se voce entendeu as entradas, consegue responder."
    ];

    question_bank_learning = [
        {
            prompt: "f(x,y) = x^2 + y^2\nQuanto vale f(1,2)?",
            options: ["1) 3", "2) 5", "3) 8"],
            correct: 2,
            solution: "f(1,2) = 1^2 + 2^2 = 1 + 4 = 5.",
            hint: "Substitua x por 1 e y por 2. Depois calcule 1^2 + 2^2.",
            wrong: "Quase. Nessa sala, a funcao precisa dos dois valores do par: x e y."
        },
        {
            prompt: "f(x,y) = 2x + y\nQuanto vale f(3,1)?",
            options: ["1) 7", "2) 5", "3) 9"],
            correct: 1,
            solution: "f(3,1) = 2*3 + 1 = 6 + 1 = 7.",
            hint: "Troque x por 3 e y por 1. A conta fica 2*3 + 1.",
            wrong: "Olhe para o par inteiro. O primeiro valor entra no lugar de x, o segundo entra no lugar de y."
        },
        {
            prompt: "f(x,y) = x + y^2\nQuanto vale f(2,3)?",
            options: ["1) 8", "2) 11", "3) 13"],
            correct: 2,
            solution: "f(2,3) = 2 + 3^2 = 2 + 9 = 11.",
            hint: "Aqui, so o y esta ao quadrado. Use x = 2 e y = 3.",
            wrong: "Cuidado com a ordem do par. Em f(2,3), x vale 2 e y vale 3."
        }
    ];

    question_bank_hard = [
        {
            prompt: "f(x,y) = x^2 + 2xy\nQuanto vale f(2,3)?",
            options: ["1) 10", "2) 16", "3) 20"],
            correct: 2,
            solution: "f(2,3) = 2^2 + 2*2*3 = 4 + 12 = 16.",
            hint: "",
            wrong: "A resposta nao fechou. Refaça a substituicao do par na expressao inteira."
        },
        {
            prompt: "f(x,y) = 3x^2 - y\nQuanto vale f(2,5)?",
            options: ["1) 7", "2) 11", "3) 17"],
            correct: 1,
            solution: "f(2,5) = 3*2^2 - 5 = 12 - 5 = 7.",
            hint: "",
            wrong: "Revise a potencia antes da multiplicacao."
        },
        {
            prompt: "f(x,y) = xy + y^2\nQuanto vale f(3,2)?",
            options: ["1) 8", "2) 10", "3) 12"],
            correct: 2,
            solution: "f(3,2) = 3*2 + 2^2 = 6 + 4 = 10.",
            hint: "",
            wrong: "A expressao usa produto entre x e y, alem do termo y^2."
        },
        {
            prompt: "f(x,y) = x^2 - y^2 + xy\nQuanto vale f(2,1)?",
            options: ["1) 3", "2) 5", "3) 7"],
            correct: 2,
            solution: "f(2,1) = 2^2 - 1^2 + 2*1 = 4 - 1 + 2 = 5.",
            hint: "",
            wrong: "Cuidado com o sinal negativo antes de y^2."
        }
    ];

    notebook_page_title = "Funcoes de varias variaveis";
    notebook_page_body = "Uma funcao de varias variaveis recebe mais de uma entrada. Nesta fase usamos f(x,y), em que x e y formam um par ordenado. Para calcular um valor da funcao, substitua cada variavel pelo valor correspondente e resolva a expressao. Exemplo: se f(x,y) = x^2 + y^2, entao f(1,2) = 1^2 + 2^2 = 5.";
}

current_question_bank = global.hard_mode ? question_bank_hard : question_bank_learning;
last_question_index = -1;
question_locked = false;
last_special_question_index = -1;

battle_refresh_question_bank = function() {
    if (battle_id == "isiaha") {
        if (isiaha_phase >= 2) {
            current_question_bank = global.hard_mode ? question_bank_hard_phase2 : question_bank_learning_phase2;
        } else {
            current_question_bank = global.hard_mode ? question_bank_hard : question_bank_learning;
        }
    } else {
        current_question_bank = global.hard_mode ? question_bank_hard : question_bank_learning;
    }
};

battle_pick_question = function() {
    battle_refresh_question_bank();
    var q_len = array_length(current_question_bank);
    var q_index = irandom(q_len - 1);

    if (q_len > 1) {
        var guard = 0;
        while (q_index == last_question_index && guard < 8) {
            q_index = irandom(q_len - 1);
            guard += 1;
        }
    }

    last_question_index = q_index;
    current_question = current_question_bank[q_index];
    question_text = current_question.prompt;
    question_options = current_question.options;
    correct_answer = current_question.correct;
    question_solution = current_question.solution;
    question_hint = current_question.hint;
    question_wrong_feedback = current_question.wrong;
};

battle_pick_special_question = function() {
    var bank = global.hard_mode ? hessian_special_hard : hessian_special_learning;
    var q_len = array_length(bank);
    var q_index = irandom(q_len - 1);

    if (q_len > 1) {
        var guard = 0;
        while (q_index == last_special_question_index && guard < 8) {
            q_index = irandom(q_len - 1);
            guard += 1;
        }
    }

    last_special_question_index = q_index;
    special_question = bank[q_index];
    special_text = special_question.prompt;
    special_options = special_question.options;
    special_correct_answer = special_question.correct;
    special_solution = special_question.solution;
    special_wrong_feedback = special_question.wrong;
};

battle_pick_question();

state = "intro";
action_index = 0;
selected_answer = 0;
wrong_answers = 0;
pending_state = "choose";
turn_count = 1;
message_speaker = "";
message_is_dialogue = false;

intro_index = 0;
battle_message = intro_lines[intro_index];
message_footer = "ENTER para continuar";
message_is_dialogue = true;

action_names = ["Atacar", "Revisar", "Dica", "Item"];
action_desc_learning = [
    "Responder uma questao e usar o conceito aprendido para causar dano.",
    "Rever a ideia principal da sala antes de passar o turno.",
    "Receber uma dica clara sobre a pergunta atual.",
    "Usar um item da mochila. Barras recuperam HP e macas recuperam 30 HP."
];
action_desc_hard = [
    "Responder uma questao mais dificil e causar dano se acertar.",
    "Ler uma revisao breve antes de passar o turno.",
    "Indisponivel no Modo Dificil.",
    "Usar um item da mochila. Barras recuperam HP e macas recuperam 30 HP."
];
action_desc = global.hard_mode ? action_desc_hard : action_desc_learning;

global.dialogue_text = "";
global.dialogue_timer = 0;
global.input_mode = "none";
