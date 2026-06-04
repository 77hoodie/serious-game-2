if (!variable_global_exists("booly_unlocked")) global.booly_unlocked = false;
if (!variable_global_exists("booly_completed")) global.booly_completed = false;

if (global.difficulty_mode == "booly") {
    message = "Voce venceu o desafio secreto do Booly.\n\nEle ainda nao sabe se carregar apostilas conta como estudar, mas agora o caderno esta completo ate no conteudo extra.\n\nO jogo principal cobre os quatro conceitos obrigatorios e o Modo Booly funciona como revisao geral pos-game.";
} else if (global.difficulty_mode == "hard" && global.booly_unlocked) {
    message = "Fim de Midnight School no Modo Dificil.\n\nO jogo principal foi concluido e o Modo Booly foi liberado na tela de dificuldade.\n\nVoce recebeu macas para o desafio secreto. Volte para a selecao de dificuldade e procure a nova opcao.";
} else {
    message = "Fim da versao atual de Midnight School.\n\nO fluxo principal cobre os quatro conceitos obrigatorios:\n1. Funcoes de varias variaveis\n2. Derivadas parciais\n3. Vetor gradiente\n4. Maximos, minimos e Hessiana\n\nO caderno de anotacoes foi preenchido conforme as batalhas vencidas.";
}
