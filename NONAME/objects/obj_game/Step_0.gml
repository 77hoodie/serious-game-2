// Atualiza caixas de dialogo, cutscenes simples e menu do jogador.
// ENTER fecha dialogos livres e avanca cutscenes.

var confirm_pressed = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
var menu_pressed = keyboard_check_pressed(ord("M"));

// Abre o menu apenas durante exploracao livre.
if ((room == rm_lab_01 || room == rm_lab_02) && global.input_mode == "none" && global.dialogue_text == "" && menu_pressed) {
    global.input_mode = "player_menu";
    global.menu_tab = 0;
    global.notebook_page_index = clamp(global.notebook_page_index, 0, max(0, array_length(global.notebook_pages) - 1));
}

if (global.input_mode == "player_menu") {
    if (menu_pressed || keyboard_check_pressed(vk_escape)) {
        global.input_mode = "none";
    }

    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
        global.menu_tab = 1 - global.menu_tab;
    }

    if (global.menu_tab == 1) {
        var page_count = array_length(global.notebook_pages);
        if (page_count > 0) {
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
                global.notebook_page_index = (global.notebook_page_index + 1) mod page_count;
            }
            if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
                global.notebook_page_index -= 1;
                if (global.notebook_page_index < 0) global.notebook_page_index = page_count - 1;
            }
        }
    }

    exit;
}

// Dialogos livres: mensagens do tutor, porta, acertos e avisos ficam paradas
// ate o jogador apertar ENTER. Isso evita andar pela room com o fundo escuro aberto.
if (global.input_mode == "none" && global.dialogue_text != "") {
    if (confirm_pressed) {
        global.dialogue_text = "";
        global.dialogue_timer = 0;
    }
}

if (global.input_mode == "lab_intro") {
    if (confirm_pressed) {
        global.lab_intro_page += 1;

        if (global.lab_intro_page >= array_length(global.lab_intro_lines)) {
            global.lab_01_intro_done = true;
            global.input_mode = "none";
            global.dialogue_text = "";
            global.dialogue_timer = 0;
        } else {
            global.dialogue_text = global.lab_intro_lines[global.lab_intro_page];
            global.dialogue_timer = -1;
        }
    }
}

if (global.input_mode == "lab_02_intro") {
    if (confirm_pressed) {
        global.lab_02_intro_page += 1;

        if (global.lab_02_intro_page >= array_length(global.lab_02_intro_lines)) {
            global.lab_02_intro_done = true;
            global.input_mode = "none";
            global.dialogue_text = "";
            global.dialogue_timer = 0;
        } else {
            global.dialogue_text = global.lab_02_intro_lines[global.lab_02_intro_page];
            global.dialogue_timer = -1;
        }
    }
}

if (global.dialogue_timer > 0) {
    global.dialogue_timer -= 1;
    if (global.dialogue_timer <= 0) global.dialogue_text = "";
}
