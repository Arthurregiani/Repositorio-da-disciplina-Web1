//variáveis globais
var labCanvas = document.getElementById("mazeCanvas");
var ctx = labCanvas.getContext("2d");
var fig;
var figFinal;
var labirinto, desenho, player;
var tamCell;
var dificuldade;


//numero aleatório
function rand(maximo) {
    return Math.floor(Math.random() * maximo);
}

//define direção aleatória
function embaralhar(array) {
    for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    const temp = array[i];
    array[i] = array[j];
    array[j] = temp;
    }
    return array;
}
//mensagem de vitoria
function displayVitória(moves) {
    document.getElementById("movimentos").innerHTML = "Voce se moveu:" + moves + "vezes";
    if (document.getElementById("Message-Container").style.visibility == "visible") {
        document.getElementById("Message-Container").style.visibility = "hidden";
    } else {
        document.getElementById("Message-Container").style.visibility = "visible";
    }
}
  
//construtor do labirinto
function Labirinto(Largura, Altura) {
    var mapaLab;
    var largura = Largura;
    var altura = Altura;
    var cordenadaInicio, cordenadaFinal;
    var direcoes = ["n", "s", "e", "w"];

    //cordenadas de movimento para cada direçao
    var modDir = {
        n: { y: -1, x: 0, o: "s"},
        s: { y: 1, x: 0, o: "n"},
        e: { y: 0, x: 1, o: "w"},
        w: { y: 0, x: -1, o: "e"}
    };

    //retorna mapa
    this.map = function () {
        return mapaLab;
    };
    //retorna a cordenada inicial
    this.startCoord = function () {
        return cordenadaInicio;
    };
    //retorna cordenada final
    this.endCoord = function () {
        return cordenadaFinal;
    };
    //gera a matrix do mapa 
    function gerarMapa() {
        mapaLab = new Array(altura);
        for (y = 0; y < altura; y++) {
            mapaLab[y] = new Array(largura);
            for (x = 0; x < largura; ++x) {
                mapaLab[y][x] = {
                    n: false,
                    s: false,
                    e: false,
                    w: false,
                    visitado: false,
                    priorPos: null
                };
            }
        }
    }

    //flags de definição
    function defineLab() {
        var completo = false;
        var mover = false;
        var cellVisitadas = 1;
        var numLoops = 0;
        var maxLoops = 0;
        var posicao = {x: 0, y: 0 };

        //numero de celulas do labirinto
        var numCells = largura * altura;

        //enquanto labirinto incompleto, percorre aleatóriamente
        while (!completo) {
            mover = false;
            mapaLab[posicao.x][posicao.y].visited = true;

            if (numLoops >= maxLoops) {
                embaralhar(direcoes);
                //define "distorção" do labirinto
                maxLoops = Math.round(rand(altura / 8));
                numLoops = 0;
            }
            numLoops++;

            for (index = 0; index < direcoes.length; index++) {
                var direcao = direcoes[index];
                var posX = posicao.x + modDir[direcao].x;
                var posY = posicao.y + modDir[direcao].y;

                if (posX >= 0 && posX < largura && posY >= 0 && posY < altura) {
                   //verificação se ja foi visitado
                    if (!mapaLab[posX][posY].visited) {
                        //percorre as paredes até a proxima
                        mapaLab[posicao.x][posicao.y][direcao] = true;
                        mapaLab[posX][posY][modDir[direcao].o] = true;

                        //define a celula anterior como já visitada
                        mapaLab[posX][posY].priorPos = posicao;
                       //Atualiza para a posicao visitada
                        posicao = {
                            x: posX,
                            y: posY
                        };
                        //incrementa numero de celulas visitadas
                        cellVisitadas++;
                        //permite movimento
                        mover = true;
                        break;
                    }
                }
            }

            if (!mover) {
                //se não encontrar uma direção, volta para a celula anterior
                posicao = mapaLab[posicao.x][posicao.y].priorPos;
            }
            //se todas as celulas forem visitadas o labirinto está completo
            if (numCells == cellVisitadas) {
                completo = true;
            }
        }
    }
    //define as posições de inicio e fim do labirinto
    function defineInicioFim() {
        switch (rand(4)) {
            case 0: cordenadaInicio = { x: 0, y: 0};
                    cordenadaFinal = { x: altura - 1, y: largura - 1};
                break;
            case 1: cordenadaInicio = { x: 0, y: largura - 1 };
                    cordenadaFinal = { x: altura - 1, y: 0 };
                break;
            case 2: cordenadaInicio = { x: altura - 1, y: 0};
                    cordenadaFinal = { x: 0, y: largura - 1 };
                break;
            case 3: cordenadaInicio = { x: altura - 1, y: largura - 1 };
                    cordenadaFinal = { x: 0, y: 0 };
                break;
        }
    }

    gerarMapa();
    defineInicioFim();
    defineLab();
}
//desenho do labirinto
function DesenhoLab(Maze, ctx, cellsize, endSprite = null) {
    var map = Maze.map();
    var cellSize = cellsize;
    var drawEndMethod;
    ctx.lineWidth = cellSize / 40;

    this.redrawMaze = function (size) {
        cellSize = size;
        ctx.lineWidth = cellSize / 50;
        desenhaMapa();
        drawEndMethod();
    };
    //se não tiver parede desenha ela
    function desenhaCelula(xCord, yCord, cell) {
        var x = xCord * cellSize;
        var y = yCord * cellSize;

        if (cell.n == false) {
            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.lineTo(x + cellSize, y);
            ctx.stroke();
        }
        if (cell.s === false) {
            ctx.beginPath();
            ctx.moveTo(x, y + cellSize);
            ctx.lineTo(x + cellSize, y + cellSize);
            ctx.stroke();
        }
        if (cell.e === false) {
            ctx.beginPath();
            ctx.moveTo(x + cellSize, y);
            ctx.lineTo(x + cellSize, y + cellSize);
            ctx.stroke();
        }
        if (cell.w === false) {
            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.lineTo(x, y + cellSize);
            ctx.stroke();
        }
    }

    function desenhaMapa() {
        for (x = 0; x < map.length; x++) {
            for (y = 0; y < map[x].length; y++) {
                desenhaCelula(x, y, map[x][y]);
            }
        }
    }

    function desenhaFlagFinal() {
        var coord = Maze.endCoord();
        var gridSize = 4;
        var fraction = cellSize / gridSize - 2;
        var colorSwap = true;
        for (let y = 0; y < gridSize; y++) {
            if (gridSize % 2 == 0) {
                colorSwap = !colorSwap;
            }
            for (let x = 0; x < gridSize; x++) {
                ctx.beginPath();
                ctx.rect(
                    coord.x * cellSize + x * fraction + 4.5,
                    coord.y * cellSize + y * fraction + 4.5,
                    fraction,
                    fraction
                );
                if (colorSwap) {
                    ctx.fillStyle = "rgba(0, 0, 0, 0.8)";
                } else {
                    ctx.fillStyle = "rgba(255, 255, 255, 0.8)";
                }
                ctx.fill();
                colorSwap = !colorSwap;
            }
        }
    }
    //desenho do final
    function desenhaFigFinal() {
        var offsetLeft = cellSize / 50;
        var offsetRight = cellSize / 25;
        var coord = Maze.endCoord();
        ctx.drawImage(
            endSprite,
            2,
            2,
            endSprite.width,
            endSprite.height,
            coord.x * cellSize + offsetLeft,
            coord.y * cellSize + offsetLeft,
            cellSize - offsetRight,
            cellSize - offsetRight
        );
    }

    function limpa() {
        var canvasSize = cellSize * map.length;
        ctx.clearRect(0, 0, canvasSize, canvasSize);
    }

    if (endSprite != null) {
        drawEndMethod = desenhaFigFinal;
    } else {
        drawEndMethod = desenhaFlagFinal;
    }
    limpa();
    desenhaMapa();
    drawEndMethod();
}
//construtor do player
function Player(lab, cont, tamCel, completo, fig = null) {
    var ctx = cont.getContext("2d");
    var desenhoFig;
    var movimentos = 0;
    desenhoFig = drawSpriteCircle;
    if (fig != null) {
        desenhoFig = drawSpriteImg;
    }
    var player = this;
    var mapa = lab.map();
    var cordCell = { x: lab.startCoord().x,
                     y: lab.startCoord().y
    };
    var tamCell = tamCel;
    var meiaCell = tamCell / 2;

    this.redrawPlayer = function (celtam) {
        tamCell = celtam;
        drawSpriteImg(cordCell);
    };

    function drawSpriteCircle(coord) {
        ctx.beginPath();
        ctx.fillStyle = "yellow";
        ctx.arc(
            (coord.x + 1) * tamCell - meiaCell,
            (coord.y + 1) * tamCell - meiaCell,
            meiaCell - 2,
            0,
            2 * Math.PI
        );
        ctx.fill();
        if (coord.x === lab.endCoord().x && coord.y === lab.endCoord().y) {
            completo(movimentos);
            player.unbindKeyDown();
        }
    }

    function drawSpriteImg(coord) {
        var offsetEsquerdo = tamCell / 50;
        var offsetDireito = tamCell / 25;
        ctx.drawImage(
            fig, 
            0, 
            0, 
            fig.width, 
            fig.height, 
            coord.x * tamCell + offsetEsquerdo, coord.y * tamCell + offsetEsquerdo,
            tamCell - offsetDireito,
            tamCell - offsetDireito
        );

        if (coord.x === lab.endCoord().x && coord.y === lab.endCoord().y) {
            completo(movimentos);
            player.unbindKeyDown();
        }
    }

    function removeSprite(coord) {
        var offsetLeft = tamCell / 50;
        var offsetRight = tamCell / 25;
        ctx.clearRect(
            coord.x * tamCell + offsetLeft,
            coord.y * tamCell + offsetLeft,
            tamCell - offsetRight,
            tamCell - offsetRight
        );
    }

    function check(e) {
        var cell = mapa[cordCell.x][cordCell.y];
        movimentos++;
        switch (e.keyCode) {
            //mapeamento do codigo das teclas
            case 37: // direita
                if (cell.w == true) {
                    removeSprite(cordCell);
                    cordCell = {
                                x: cordCell.x - 1,
                                y: cordCell.y
                    };
                    desenhoFig(cordCell);
                }
                break;

            case 38: // cima
                if (cell.n == true) {
                    removeSprite(cordCell);
                    cordCell = {
                                x: cordCell.x,
                                y: cordCell.y - 1
                    };
                    desenhoFig(cordCell);
                }
                break;

            case 39: // esquerda
                if (cell.e == true) {
                    removeSprite(cordCell);
                    cordCell = {
                                x: cordCell.x + 1,
                                y: cordCell.y
                    };
                    desenhoFig(cordCell);
                }
                break;

            case 40: // sul
                if (cell.s == true) {
                    removeSprite(cordCell);
                    cordCell = {
                                x: cordCell.x,
                                y: cordCell.y + 1
                    };
                    desenhoFig(cordCell);
                }
                break;
        }
    }

    this.bindKeyDown = function () {
        window.addEventListener("keydown", check, false);

        $("#view").swipe({
            swipe: function (
                event,
                direction,
                distance,
                duration,
                fingerCount,
                fingerData
            ) {
                console.log(direction);
                switch (direction) {
                    //mapeando teclas
                    case "left":
                        check({
                            keyCode: 37
                        });
                        break;
                    case "up":
                        check({
                            keyCode: 38
                        });
                        break;
                    case "right":
                        check({
                            keyCode: 39
                        });
                        break;
                    case "down":
                        check({
                            keyCode: 40
                        });
                        break;
                }
            },
            threshold: 0
        });
    };

    this.unbindKeyDown = function () {
        window.removeEventListener("keydown", check, false);
        $("#view").swipe("destroy");
    };

    desenhoFig(lab.startCoord());

    this.bindKeyDown();
}

//view
window.onload = function () {
    let viewWidth = $("#view").width();
    let viewHeight = $("#view").height();
    if (viewHeight < viewWidth) {
        ctx.canvas.width = viewHeight - viewHeight / 100;
        ctx.canvas.height = viewHeight - viewHeight / 100;
    } else {
        ctx.canvas.width = viewWidth - viewWidth / 100;
        ctx.canvas.height = viewWidth - viewWidth / 100;
    }

    //adciona as figuras
    var completeOne = false;
    var completeTwo = false;
    var isComplete = () => {
        if (completeOne === true && completeTwo === true) {
            console.log("Runs");
            setTimeout(function () {
                start();
            }, 500);
        }
    };
    fig = new Image();
    fig.src ="cigarro-1459083461.png" + "?" + new Date().getTime();
    fig.setAttribute("crossOrigin", " ");
    fig.onload = function () {
        fig = changeBrightness(1.2, fig);
        completeOne = true;
        console.log(completeOne);
        isComplete();
    };

    figFinal = new Image();
    figFinal.src = "isqueiro-1244065288.png" + "?" + new Date().getTime();
    figFinal.setAttribute("crossOrigin", " ");
    figFinal.onload = function () {
        figFinal = changeBrightness(1.1, figFinal);
        completeTwo = true;
        console.log(completeTwo);
        isComplete();
    };

};

//view responsiva
window.onresize = function () {
    let viewWidth = $("#view").width();
    let viewHeight = $("#view").height();
    if (viewHeight < viewWidth) {
        ctx.canvas.width = viewHeight - viewHeight / 100;
        ctx.canvas.height = viewHeight - viewHeight / 100;
    } else {
        ctx.canvas.width = viewWidth - viewWidth / 100;
        ctx.canvas.height = viewWidth - viewWidth / 100;
    }
    tamCell = labCanvas.width / dificuldade;
    if (player != null) {
        desenho.redrawMaze(tamCell);
        player.redrawPlayer(tamCell);
    }
};

//inicio
function start() {
    //document.getElementById("mazeCanvas").classList.add("border");
    if (player != undefined) {
        player.unbindKeyDown();
        player = null;
    }

    dificuldade = 25;
    //tamanho dos elementos
    tamCell = labCanvas.width / dificuldade;
    //gera o labirinto
    labirinto = new Labirinto(dificuldade, dificuldade);
    //gera desenho do labirinto
    desenho = new DesenhoLab(labirinto, ctx, tamCell, figFinal);
    player = new Player(labirinto, labCanvas, tamCell, displayVitória, fig);
    if (document.getElementById("mazeContainer").style.opacity < "100") {
        document.getElementById("mazeContainer").style.opacity = "100";
    }
}