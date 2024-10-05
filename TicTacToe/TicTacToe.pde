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

//possible symbols to be added to board
char[] players = {'x', 'o'};
//index of players array, represents whose turn it is
int player;

//represents what number turn it is. when >8, game is a draw
int turn;

void setup() {
  turn = 1;
  //start game on x's turn
  player = 0;
  printBoard();
  print(players[player] + "'s turn\n");
}

void draw(){}

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

void placeSymbol(int x, int y) {
  board[x][y] = players[player];
  printBoard();
  turn++;
  if(turn > 9) {
    print("draw. press 'r' to reset or 'e' to exit\n");
  }
  else if(checkWin(x, y, players[player])) {
    print(players[player] + " win! press 'r' to reset or 'e' to exit\n");
  }
  else {
    player = (player+1)%players.length;
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
  printBoard();
  print(players[player] + "'s turn");
}
