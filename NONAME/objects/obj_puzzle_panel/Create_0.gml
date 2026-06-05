label = "Quadro";

lab_01_board_text = function() {
    return "QUADRO - Funcoes de varias variaveis\n\nUma funcao f(x,y) recebe dois valores.\nO primeiro valor substitui x.\nO segundo valor substitui y.\n\nExemplo:\nf(1,2) significa x=1 e y=2.\n\nQuestao:\nf(x,y)=x^2+y^2\nQuanto vale f(1,2)?\n\n1) 3\n2) 5\n3) 8";
};

lab_02_board_text = function() {
    if (global.hard_mode) {
        return "QUADRO - Derivadas parciais\n\nQuando derivamos em relacao a y, x permanece constante.\nApenas os termos com y mudam.\n\nExemplo:\n5x+y^2 -> df/dy=2y\n\nQuestao:\nf(x,y)=x^2*y+4y^2\nQual e df/dy no ponto (2,1)?\n\n1) 8\n2) 10\n3) 12";
    }

   return "QUADRO - Derivadas parciais\n\nUma derivada parcial observa apenas uma variavel por vez.\nQuando derivamos em relacao a x, y fica constante.\n\nExemplo:\nf(x,y)=x^2+3y\nA derivada em x e 2x.\n\nQuestao:\nf(x,y)=x^2+3y\nQual e df/dx no ponto (2,1)?\n\n1) 3\n2) 4\n3) 7";
};

lab_03_board_text = function() {
    if (global.hard_mode) {
        return "MESA CARTOGRAFICA - Vetor gradiente\n\nO gradiente e formado pelas derivadas parciais.\n\ngrad f=(df/dx,df/dy)\n\nCalcule as duas derivadas antes de substituir o ponto.\n\nQuestao:\nf(x,y)=2x^2+xy\nNo ponto (1,2), qual e grad f?\n\n1) (4,2)\n2) (6,1)\n3) (2,6)";
    }
		return "MESA CARTOGRAFICA - Vetor gradiente\n\nO gradiente junta as duas derivadas parciais.\n\ngrad f=(df/dx,df/dy)\n\nPrimeiro calcule df/dx.\nDepois calcule df/dy.\n\nQuestao:\nf(x,y)=x^2+y^2\nNo ponto (1,2), qual e grad f?\n\n1) (2,4)\n2) (1,2)\n3) (4,2)";
};


lab_04_board_text = function() {
    if (global.lab_04_puzzle_stage <= 0) {
        if (global.hard_mode) {
            return "PEDESTAL - Pontos criticos\n\nUm ponto critico ocorre quando df/dx=0 e df/dy=0 ao mesmo tempo.\n\nResolva as duas equacoes simultaneamente.\n\nQuestao:\nf(x,y)=x^2+2y^2\nQual e o ponto critico?\n\n1) (0,0)\n2) (1,0)\n3) (0,2)";
        }
       return "PEDESTAL - Pontos criticos\n\nUm ponto critico ocorre quando todas as derivadas parciais valem zero.\n\nPasso 1: calcule df/dx.\nPasso 2: calcule df/dy.\nPasso 3: encontre onde ambas zeram.\n\nQuestao:\nf(x,y)=x^2+y^2\nQual e o ponto critico?\n\n1) (0,0)\n2) (1,1)\n3) (2,0)";
    }

    if (global.hard_mode) {
      return "PEDESTAL - Hessiana\n\nfxx=curva em X (2ªderiv) fyy = curva em Y fxy = mistura X/Y\nD= fxx * fyy - (fxy)^2\n D < 0 = sela | D > 0 → fxx define o tipo\nfxx > 0 = MIN (vale baixa) fxx < 0 = MAX (pico)\n\nH=\n[fxx fxy]\n[fxy fyy]\nex:\n[2 0]\n[0 -2]\n\n1)Max 2)Min 3)Sela";
    }

return "PEDESTAL - Hessiana\n\nfxx = curva em X (2ªderiv) fyy = curva em Y fxy=mistura X/Y\nD = fxx * fyy - (fxy)^2\nD > 0 & fxx > 0 = min (vale) D > 0 & fxx < 0 = max (pico) D < 0 = sela\n\nH=\n[fxx fxy]\n[fxy fyy]\nex:\n[2 0]\n[0 2]\n\n1)Max 2)Min 3)Sela";
};

interact = function() {
    if (room == rm_lab_04) {
        if (global.lab_04_puzzle_solved) {
            global.dialogue_text = "Pedestal: a classificacao ja foi aceita. A porta esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_04";
            global.dialogue_text = lab_04_board_text();
            global.dialogue_timer = -1;
        }
    } else if (room == rm_lab_03) {
        if (global.lab_03_puzzle_solved) {
            global.dialogue_text = "Mesa: o vetor ja foi marcado no mapa. A passagem esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_03";
            global.dialogue_text = lab_03_board_text();
            global.dialogue_timer = -1;
        }
    } else if (room == rm_lab_02) {
        if (global.lab_02_puzzle_solved) {
            global.dialogue_text = "Quadro: resposta ja escrita. A porta esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_02";
            global.dialogue_text = lab_02_board_text();
            global.dialogue_timer = -1;
        }
    } else {
        if (global.lab_01_puzzle_solved) {
            global.dialogue_text = "Quadro: resposta ja escrita. f(1,2) = 5. A porta verde esta liberada.";
            global.dialogue_timer = -1;
        } else {
            global.input_mode = "puzzle_lab_01";
            global.dialogue_text = lab_01_board_text();
            global.dialogue_timer = -1;
        }
    }
};
