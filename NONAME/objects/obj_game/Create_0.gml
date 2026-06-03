// Controlador global do prototipo.
// Mantem estados simples de tutorial, puzzle e UI.
// Profundidade negativa para a UI sempre desenhar por cima dos objetos da sala.
depth = -100000;

if (!variable_global_exists("difficulty_mode")) global.difficulty_mode = "learning";
if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("lab_01_puzzle_solved")) global.lab_01_puzzle_solved = false;
if (!variable_global_exists("lab_01_intro_done")) global.lab_01_intro_done = false;
if (!variable_global_exists("input_mode")) global.input_mode = "none";
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = 0;
if (!variable_global_exists("puzzle_attempts")) global.puzzle_attempts = 0;

// Reinicia apenas o estado da fase, preservando a dificuldade escolhida no menu.
global.lab_01_puzzle_solved = false;
global.puzzle_attempts = 0;
global.dialogue_timer = -1;


// Colisoes invisiveis da primeira sala.
// Cada retangulo segue o formato [x1, y1, x2, y2] em coordenadas da room.
// A imagem do mapa e apenas visual; esses retangulos definem onde o player pode andar.
global.lab_01_collision_rects = [
    // limites externos da sala
    [0, 0, 1366, 198],
    [0, 704, 1366, 768],
    [0, 0, 94, 768],
    [1268, 0, 1366, 768],

    // paredes/recortes laterais aproximados
    [94, 0, 130, 210],
    [94, 625, 155, 768],
    [1205, 0, 1268, 185],
    [1218, 330, 1268, 768],

    // objetos grandes encostados nas paredes
    [190, 120, 305, 245],
    [960, 205, 1045, 306],

    // mesa do professor
    [610, 238, 772, 312],

    // carteiras do lado esquerdo
    [288, 300, 385, 382],
    [238, 412, 345, 492],
    [223, 520, 343, 610],
    [348, 465, 455, 545],
    [252, 617, 350, 695],

    // carteiras do lado direito
    [866, 300, 965, 382],
    [1012, 392, 1115, 485],
    [862, 488, 970, 570],
    [1020, 505, 1135, 592],
    [836, 610, 952, 698],
    [1008, 608, 1125, 698]
];

// Ative manualmente para visualizar os retangulos de colisao durante ajustes.
global.debug_collisions = false;

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
} else {
    global.input_mode = "none";
    global.dialogue_text = "";
}
