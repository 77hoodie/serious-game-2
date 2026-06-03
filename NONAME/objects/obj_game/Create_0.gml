// Controlador global do prototipo.
// Mantem estados simples de tutorial, puzzle e UI.

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
