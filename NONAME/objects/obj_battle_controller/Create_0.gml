// Controlador de batalha padronizado.
// Ele escolhe os dados da batalha a partir da room atual ou de global.current_battle.

if (!variable_global_exists("difficulty_mode")) global.difficulty_mode = "learning";
if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = -1;
if (!variable_global_exists("notebook_pages")) global.notebook_pages = [];
if (!variable_global_exists("item_cereal_bars")) global.item_cereal_bars = 0;
if (!variable_global_exists("notebook_monitor_sem_rosto")) global.notebook_monitor_sem_rosto = false;
if (!variable_global_exists("notebook_aluna_janela")) global.notebook_aluna_janela = false;
if (!variable_global_exists("reward_monitor_items")) global.reward_monitor_items = false;
if (!variable_global_exists("last_room_before_battle")) global.last_room_before_battle = rm_lab_01;

if (!variable_global_exists("current_battle")) {
    global.current_battle = (room == rm_battle_02) ? "aluna" : "monitor";
}

if (room == rm_battle_02) {
    global.current_battle = "aluna";
} else if (room == rm_battle_01) {
    global.current_battle = "monitor";
}

battle_id = global.current_battle;

if (!variable_global_exists("battle_music")) global.battle_music = noone;
if (global.battle_music == noone) {
    global.battle_music = audio_play_sound(snd_battle_theme, 10, true);
}

randomize();

// Dados do jogador. A vida e restaurada ao entrar em cada batalha por enquanto.
if (!variable_global_exists("player_max_hp")) global.player_max_hp = 30;
global.player_hp = global.player_max_hp;
player_hp = global.player_hp;
max_player_hp = global.player_max_hp;

// Dados visuais do jogador em todas as batalhas.
player_battle_sprite = sprite_player_battle;
player_battle_scale = 0.34;
player_battle_x = 260;
player_battle_y = 560;

mode_label = global.hard_mode ? "Modo Dificil" : "Modo Aprendizado";

// Configuracoes especificas por batalha.
if (battle_id == "aluna") {
    battle_number_label = "Batalha 02";
    battle_concept_label = "Derivadas parciais";
    battle_background_sprite = sprite_battle_room_02;
    victory_room = rm_end;
    reset_room = rm_lab_02;

    enemy_name = "Aluna da Janela";
    enemy_hp = global.hard_mode ? 34 : 20;
    max_enemy_hp = enemy_hp;
    enemy_damage_min = global.hard_mode ? 6 : 2;
    enemy_damage_max = global.hard_mode ? 10 : 4;
    player_attack_damage = global.hard_mode ? 7 : 8;
    enemy_battle_sprite = sprite_aluna_battle;
    enemy_dialogue_sprite = sprite_aluna_dialogue;
    enemy_battle_scale = 0.34;
    enemy_battle_x = room_width - 300;
    enemy_battle_y = 560;

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
    enemy_battle_scale = 0.34;
    enemy_battle_x = room_width - 300;
    enemy_battle_y = 560;

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

battle_pick_question = function() {
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
    "Usar um item da mochila. Barras de cereal recuperam HP."
];
action_desc_hard = [
    "Responder uma questao mais dificil e causar dano se acertar.",
    "Ler uma revisao breve antes de passar o turno.",
    "Indisponivel no Modo Dificil.",
    "Usar um item da mochila. Barras de cereal recuperam HP."
];
action_desc = global.hard_mode ? action_desc_hard : action_desc_learning;

global.dialogue_text = "";
global.dialogue_timer = 0;
global.input_mode = "none";
