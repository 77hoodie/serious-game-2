// Controlador global do prototipo.
// Mantem estados simples de tutorial, puzzle, inventario, caderno e UI.
// Profundidade negativa para a UI sempre desenhar por cima dos objetos da sala.
depth = -100000;

if (!variable_global_exists("difficulty_mode")) global.difficulty_mode = "learning";
if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("player_max_hp")) global.player_max_hp = 30;
if (!variable_global_exists("player_hp")) global.player_hp = global.player_max_hp;
if (!variable_global_exists("hp_bonus_after_monitor")) global.hp_bonus_after_monitor = false;
if (!variable_global_exists("hp_bonus_after_aluna")) global.hp_bonus_after_aluna = false;

if (!variable_global_exists("lab_01_puzzle_solved")) global.lab_01_puzzle_solved = false;
if (!variable_global_exists("lab_02_puzzle_solved")) global.lab_02_puzzle_solved = false;
if (!variable_global_exists("lab_01_intro_done")) global.lab_01_intro_done = false;
if (!variable_global_exists("lab_02_intro_done")) global.lab_02_intro_done = false;

if (!variable_global_exists("input_mode")) global.input_mode = "none";
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = 0;
if (!variable_global_exists("puzzle_attempts")) global.puzzle_attempts = 0;
if (!variable_global_exists("puzzle_attempts_lab_02")) global.puzzle_attempts_lab_02 = 0;

// Inventario e caderno.
if (!variable_global_exists("item_cereal_bars")) global.item_cereal_bars = 0;
if (!variable_global_exists("notebook_pages")) global.notebook_pages = [];
if (!variable_global_exists("notebook_page_index")) global.notebook_page_index = 0;
if (!variable_global_exists("menu_tab")) global.menu_tab = 0;

// Colisoes invisiveis da primeira sala.
global.lab_01_collision_rects = [
    [0, 0, 1366, 198],
    [0, 704, 1366, 768],
    [0, 0, 94, 768],
    [1268, 0, 1366, 768],
    [94, 0, 130, 210],
    [94, 625, 155, 768],
    [1205, 0, 1268, 185],
    [1218, 330, 1268, 768],
    [190, 120, 305, 245],
    [960, 205, 1045, 306],
    [610, 238, 772, 312],
    [288, 300, 385, 382],
    [238, 412, 345, 492],
    [223, 520, 343, 610],
    [348, 465, 455, 545],
    [252, 617, 350, 695],
    [866, 300, 965, 382],
    [1012, 392, 1115, 485],
    [862, 488, 970, 570],
    [1020, 505, 1135, 592],
    [836, 610, 952, 698],
    [1008, 608, 1125, 698]
];

// Colisoes invisiveis da segunda sala.
// A sala tem janelas na esquerda, quadro no topo e carteiras nas laterais.
global.lab_02_collision_rects = [
    // limites externos
    [0, 0, 1366, 170],
    [0, 716, 1366, 768],
    [0, 0, 102, 768],
    [1270, 0, 1366, 768],

    // paredes/recortes laterais
    [102, 0, 136, 214],
    [101, 610, 170, 768],
    [1168, 0, 1270, 206],
    [1184, 320, 1270, 768],

    // armarios e objetos perto do quadro
    [262, 112, 340, 236],
    [346, 170, 416, 232],
    [642, 215, 724, 305],
    [932, 120, 1000, 190],

    // carteiras lado esquerdo
    [330, 312, 425, 382],
    [460, 312, 552, 382],
    [330, 412, 425, 485],
    [460, 412, 552, 485],
    [330, 515, 425, 590],
    [460, 515, 552, 590],
    [330, 620, 425, 696],
    [460, 620, 552, 696],

    // carteiras lado direito
    [875, 312, 968, 382],
    [1000, 312, 1094, 382],
    [875, 412, 968, 485],
    [1000, 412, 1094, 485],
    [875, 515, 968, 590],
    [1000, 515, 1094, 590],
    [875, 620, 968, 696],
    [1000, 620, 1094, 696]
];

// Ative manualmente para visualizar os retangulos de colisao durante ajustes.
global.debug_collisions = false;

// Configuracao de entrada da sala atual.
global.input_mode = "none";
global.dialogue_text = "";
global.dialogue_timer = -1;

if (room == rm_lab_01) {
    // Reinicia apenas o estado jogavel da fase 1 quando a room e criada.
    global.lab_01_puzzle_solved = false;
    global.puzzle_attempts = 0;

    global.lab_intro_page = 0;
    global.lab_intro_lines = [
        "Tutor: Ei. Voce tambem apareceu aqui agora?",
        "Eu: Acho que sim. Eu estava no laboratorio... depois a tela ficou preta. Quando percebi, estava nessa sala.",
        "Tutor: Entao nao foi so comigo. Eu acordei aqui faz pouco tempo e tambem nao entendi como cheguei.",
        "Tutor: Tentei sair por aquela porta, mas ela nao abre. Pelo visto precisa escrever a resposta no quadro.",
        "Tutor: Se precisar, fala comigo. Nao sei tudo sobre esse lugar, mas posso ajudar a entender o que o quadro esta pedindo."
    ];

    if (!global.lab_01_intro_done) {
        global.input_mode = "lab_intro";
        global.dialogue_text = global.lab_intro_lines[0];
    }
}
else if (room == rm_lab_02) {
    global.lab_02_puzzle_solved = false;
    global.puzzle_attempts_lab_02 = 0;

    global.lab_02_intro_page = 0;
    global.lab_02_intro_lines = [
        "Tutor: Essa sala parece diferente. As janelas chamam atencao, mas o quadro ainda esta no controle.",
        "Eu: Tem outra porta trancada. De novo.",
        "Tutor: O assunto agora deve ser derivada parcial. Pelo que eu entendi, a sala quer que voce olhe para uma variavel por vez.",
        "Tutor: Se a pergunta for sobre x, tente manter y parado. Se for sobre y, mantenha x parado.",
        "Tutor: Escreve a resposta no quadro quando estiver pronto. Eu fico por aqui se precisar revisar."
    ];

    if (!global.lab_02_intro_done) {
        global.input_mode = "lab_02_intro";
        global.dialogue_text = global.lab_02_intro_lines[0];
    }
}
