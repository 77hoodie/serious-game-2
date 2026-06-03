// Controlador global do prototipo.
// Mantem estados simples de tutorial, puzzle e UI.

if (!variable_global_exists("difficulty_mode")) global.difficulty_mode = "learning";
if (!variable_global_exists("hard_mode")) global.hard_mode = false;
if (!variable_global_exists("lab_01_puzzle_solved")) global.lab_01_puzzle_solved = false;
if (!variable_global_exists("input_mode")) global.input_mode = "none";
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = 0;
if (!variable_global_exists("puzzle_attempts")) global.puzzle_attempts = 0;

// Reinicia apenas o estado da fase, preservando a dificuldade escolhida no menu.
global.lab_01_puzzle_solved = false;
global.input_mode = "none";
global.puzzle_attempts = 0;

if (global.hard_mode) {
    global.dialogue_text = "Modo dificil ativo. WASD move | E interage | Resolva o painel para abrir a porta.";
} else {
    global.dialogue_text = "Modo aprendizado ativo. WASD move | E interage | Resolva o painel para abrir a porta. Erros geram dicas.";
}

global.dialogue_timer = -1;
