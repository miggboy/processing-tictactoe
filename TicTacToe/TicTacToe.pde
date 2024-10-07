/* Program for playing tic-tac-toe. For now, everything is command line based.
   Switches between x turn and o turn. Use number keys to select where symbol
   is placed.
   -------
   |1|2|3|
   -------
   |4|5|6|
   -------
   |7|8|9|
   -------
   If it's x's turn, pressing '1' places an x in the space marked 1.
*/

//3x3 tic-tac-toe board
char[][] board = {{' ', ' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '}};

/* winRows represents possible winning rows corresponding to each space
   i.e. board[0][1] can make a win with board[0][0] and board[0][2] 
   or with board[1][1] and board[2][1], so winRows[0][1] consists of
   {0, 0, 0, 2} and {1, 1, 2, 1}
*/
//There's probably a more efficient way to store this but idc
int[][][][] winRows = {{{{1, 0, 1, 1}, {1, 1, 2, 2}, {0, 1, 0, 2}},             //winning rows for board[0][0]
                      {{0, 0, 0, 2}, {1, 1, 2, 1}},                             //winning rows for board[0][1]
                      {{1, 2, 2, 2}, {1, 1, 2, 0}, {0, 1, 0, 0}}},              //winning rows for board[0][2]
                      {{{0, 0, 2, 0}, {1, 1, 1, 2}},                            //winning rows for board[1][0]
                      {{0, 1, 2, 1}, {1, 0, 1, 2}, {0, 0, 2, 2}, {0, 2, 2, 0}}, //winning rows for board[1][1]
                      {{0, 2, 2, 2}, {1, 0, 1, 1}}},                            //winning rows for board[1][2]
                      {{{1, 0, 0, 0}, {2, 1, 2, 2}, {1, 1, 0, 2}},              //winning rows for board[2][0]
                      {{1, 1, 0, 1}, {2, 0, 2, 2}},                             //winning rows for board[2][1]
                      {{1, 2, 0, 2}, {2, 1, 2, 0}, {1, 1, 0, 0}}}};             //winning rows for board[2][2]
                     
//used for board layout in console
String line = "\n-------\n";

//Default Colors
color xColor = color(255,100,0);
color oColor = color(184, 37, 162);
color lineColor = color(255);
color drawColor = color(212, 40, 98);
color winColor = color(24, 214, 144);

//possible symbols to be added to board
char[] players = {'x', 'o'};
//index of players array, represents whose turn it is
int player;

// Checks if game is over
boolean gameOver = false;

//represents what number turn it is. when >8, game is a draw
int turn;

//message for label
String message = "x's turn";
color messageColour = color(xColor);

void setup() {
  turn = 1;
  //start game on x's turn
  player = 0;
  printBoard();
  print(players[player] + "'s turn\n");
  
  
  size(300, 400);
  textSize(32);
  textAlign(CENTER, CENTER);
  
}

void draw(){
  background(0);
  
  //Call draw functions
  drawGrid();
  drawSymbols();
  drawLabel();
}

//Function draws a grid
void drawGrid(){
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(0, 300, 300, 300);
  stroke(lineColor);
}

//Function draws symbols if they exist
void drawSymbols() {
  textSize(64);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 'x') {
        fill(xColor); //X's are blue
        text("X", j * 100 + 50, i * 100 + 50);
      } else if (board[i][j] == 'o') {
        fill(oColor); //O's are red
        text("O", j * 100 + 50, i * 100 + 50);
      }
    }
  }
}

//Function draws the bottom label
void drawLabel(){
  textSize(25);
  fill(messageColour);
  text(message, width/2, height - 25);
}


void keyPressed() {
  switch(key) {
    
    case '1':
      if(board[0][0] == ' ') placeSymbol(0, 0);
      break;
    case '2':
      if(board[0][1] == ' ') placeSymbol(0, 1);
      break;
    case '3':
      if(board[0][2] == ' ') placeSymbol(0, 2);
      break;
    case '4':
      if(board[1][0] == ' ') placeSymbol(1, 0);
      break;
    case '5':
      if(board[1][1] == ' ') placeSymbol(1, 1);
      break;
    case '6':
      if(board[1][2] == ' ') placeSymbol(1, 2);
      break;
    case '7':
      if(board[2][0] == ' ') placeSymbol(2, 0);
      break;
    case '8':
      if(board[2][1] == ' ') placeSymbol(2, 1);
      break;
    case '9':
      if(board[2][2] == ' ') placeSymbol(2, 2);
      break;
    case 'r':
      resetBoard();
      break;
    case 'e':
      System.exit(0);
      break;
  }
}

//Clicking on board sets symbol in corresponding box
void mousePressed() {
  if (mouseY < 300) {
    int col = mouseX / 100;
    int row = mouseY / 100;
    
    if (board[row][col] == ' ') {
      placeSymbol(row, col);
    }
  }
}

void placeSymbol(int x, int y) {
  
  //If game is over don't allow symbol to be placed
  if(gameOver){return;}
  
   board[x][y] = players[player];
   printBoard();
   turn++;
  
  if(checkWin(x, y, players[player])) { //<>//
    gameOver = true;
    textSize(25);
    messageColour = color(winColor);
    message = players[player] + " win! press 'r'\nto reset or 'e' to exit";
    print(players[player] + " win! press 'r' to reset or 'e' to exit\n");
  }
  else if(turn > 9) {
    textSize(25);
    messageColour = color(drawColor);
    message = "draw. press 'r'\nto reset or 'e' to exit";
    print("draw. press 'r' to reset or 'e' to exit\n");
  }
  else {
    player = (player+1)%players.length;
    message = players[player] + "'s turn";
    if(players[player] == 'x'){
      messageColour = xColor;
    } else {
      messageColour = oColor;
    }
    
    print(players[player] + "'s turn\n");
  }
}

boolean checkWin(int x, int y, char player) {
  boolean win = false;
  int[][] check = winRows[x][y];
  for(int i = 0; i < check.length; i++) {
    if(board[check[i][0]][check[i][1]] == player && board[check[i][2]][check[i][3]] == player) {
      win = true;
      break;
    }
  }
  return win;
}

void printBoard() {
  print(line);
  for(int i = 0; i < board.length; i++) {
    print("|");
    for(int j = 0; j < board[i].length; j++) {
      print(board[i][j] + "|");
    }
    print(line);
  }
}

void resetBoard() {
  for(int i = 0; i < board.length; i++) {
    for(int j = 0; j < board[i].length; j++) {
      board[i][j] = ' ';
    }
  }
  turn = 1;
  player = 0;
  gameOver = false;
  printBoard();
  
  if(players[player] == 'x'){
    messageColour = color(xColor);
  } else {
    messageColour = color(oColor);
  }
  
  textSize(32);
  message = players[player] + "'s turn";
  print(players[player] + "'s turn");
}
