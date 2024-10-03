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
char[][] board = {{' ', ' ',' '}, {' ', ' ', ' '}, {' ', ' ', ' '}};
//used for board layout in console
String line = "\n-------\n";

//possible symbols to be added to board
char[] players = {'x', 'o'};
//index of players array, represents whose turn it is
int turn;

void setup() {
  //start game on x's turn
  turn = 0;
  printBoard();
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
  }
}

void placeSymbol(int x, int y) {
  board[x][y] = players[turn];
  turn = (turn+1)%players.length;
  printBoard();
}

void printBoard() {
  print(players[turn] + " turn");
  print(line);
  for(int i = 0; i < board.length; i++) {
    print("|");
    for(int j = 0; j < board[i].length; j++) {
      print(board[i][j] + "|");
    }
    print(line);
  }
}
