// Controlador global do prototipo.
// Mantem estados simples de tutorial, puzzle e UI.

if (!variable_global_exists("lab_01_puzzle_solved")) global.lab_01_puzzle_solved = false;
if (!variable_global_exists("input_mode")) global.input_mode = "none";
if (!variable_global_exists("dialogue_text")) global.dialogue_text = "";
if (!variable_global_exists("dialogue_timer")) global.dialogue_timer = 0;
if (!variable_global_exists("hard_mode")) global.hard_mode = false;

// Reinicia o estado da primeira fase ao abrir o jogo.
global.lab_01_puzzle_solved = false;
global.input_mode = "none";
global.puzzle_attempts = 0;
global.dialogue_text = "WASD move | E interage | Resolva o painel para abrir a porta. O erro gera dicas, nao punicao.";
global.dialogue_timer = -1;
global.hard_mode = false;
