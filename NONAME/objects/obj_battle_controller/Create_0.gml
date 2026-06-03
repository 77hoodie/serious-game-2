// Controlador de batalha padronizado.
// Esta batalha usa o Monitor Sem Rosto como primeiro inimigo.

if (!variable_global_exists("difficulty_mode")) global.difficulty_mode = "learning";
if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = -1;

if (!variable_global_exists("battle_music")) global.battle_music = noone;
if (global.battle_music == noone) {
    global.battle_music = audio_play_sound(snd_battle_theme, 10, true);
}

randomize();

// Dados do jogador. Nesta primeira batalha, a vida e restaurada ao entrar.
if (!variable_global_exists("player_max_hp")) global.player_max_hp = 30;
global.player_hp = global.player_max_hp;

player_hp = global.player_hp;
max_player_hp = global.player_max_hp;

// Dados visuais do jogador em todas as batalhas.
player_battle_sprite = sprite_player_battle;
player_battle_scale = 0.34;
player_battle_x = 260;
player_battle_y = 560;

// Configuracao por dificuldade.
if (global.hard_mode) {
    enemy_start_hp = 34;
    enemy_damage = 8;
    player_attack_damage = 6;
    mode_label = "Modo Dificil";
    review_text = "Eu: Revisao rapida. Uma funcao de duas variaveis recebe um par ordenado. Na hora de calcular f(x,y), os dois valores precisam entrar na expressao.";
} else {
    enemy_start_hp = 12;
    enemy_damage = 1;
    player_attack_damage = 8;
    mode_label = "Modo Aprendizado";
    review_text = "Eu: Vou revisar com calma. A funcao recebe dois valores, x e y. Para calcular f(1,2), eu substituo x por 1, y por 2, e so depois faco as contas.";
}

// Dados do inimigo atual.
enemy_name = "Monitor Sem Rosto";
enemy_hp = enemy_start_hp;
max_enemy_hp = enemy_start_hp;
enemy_battle_sprite = sprite_msr_battle;
enemy_dialogue_sprite = sprite_msr_dialogue;
enemy_battle_scale = 0.34;
enemy_battle_x = room_width - 300;
enemy_battle_y = 560;

// Bancos de perguntas. O combate sorteia uma pergunta sempre que o jogador usa Atacar.
// Se o jogador pedir Dica no Modo Aprendizado, a dica prepara uma pergunta e o proximo Atacar usa essa mesma pergunta.
// Banco do Modo Aprendizado: contas mais diretas e dicas mais claras.
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

// Banco do Modo Dificil: expressoes com mais termos e menos apoio.
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

current_question_bank = global.hard_mode ? question_bank_hard : question_bank_learning;
last_question_index = -1;
question_locked = false;

battle_pick_question = function() {
    var q_len = array_length(current_question_bank);
    var q_index = irandom(q_len - 1);

    // Evita repetir a mesma pergunta imediatamente quando houver mais de uma opcao.
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

// Define uma pergunta inicial para habilitar dicas antes do primeiro ataque.
battle_pick_question();

// Estado geral do combate.
state = "intro";
action_index = 0;
selected_answer = 0;
wrong_answers = 0;
pending_state = "choose";
turn_count = 1;
message_speaker = "";
message_is_dialogue = false;

// Intro antes da batalha. Mantem o tom natural, sem explicar tudo de uma vez.
intro_index = 0;
intro_lines = [
    "Monitor Sem Rosto: Voce abriu a porta.",
    "Eu: Quem e voce?",
    "Monitor Sem Rosto: Eu fico onde as salas acabam. Nao lembro quando comecei.",
    "Eu: Voce tambem esta preso aqui?",
    "Monitor Sem Rosto: Talvez. Por enquanto, eu so verifico quem tenta passar.",
    "Monitor Sem Rosto: O quadro te deu uma regra. Se voce entendeu as entradas, consegue responder."
];

battle_message = intro_lines[intro_index];
message_footer = "ENTER para continuar";
message_is_dialogue = true;

// Menus e textos padronizados.
action_names = ["Atacar", "Revisar", "Dica", "Item"];
action_desc_learning = [
    "Responder uma questao e usar o conceito aprendido para causar dano.",
    "Rever a ideia principal da sala antes de passar o turno.",
    "Receber uma dica clara sobre a pergunta atual.",
    "Abrir a mochila. Por enquanto, ela esta vazia."
];
action_desc_hard = [
    "Responder uma questao mais dificil e causar dano se acertar.",
    "Ler uma revisao breve antes de passar o turno.",
    "Indisponivel no Modo Dificil.",
    "Abrir a mochila. Por enquanto, ela esta vazia."
];
action_desc = global.hard_mode ? action_desc_hard : action_desc_learning;

// Limpa textos globais da exploracao ao entrar na batalha.
global.dialogue_text = "";
global.dialogue_timer = 0;
global.input_mode = "none";
