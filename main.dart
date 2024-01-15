import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> board;
  late String currentPlayer;
  String? winner;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    board = List.generate(3, (i) => List.generate(3, (j) => ''));
    currentPlayer = 'X';
    winner = null;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner == null) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkForWinner(row, col)) {
          winner = currentPlayer;
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool checkForWinner(int row, int col) {
    if (board[row].every((element) => element == currentPlayer)) {
      return true;
    }

    if (List.generate(3, (i) => board[i][col]).every((element) => element == currentPlayer)) {
      return true;
    }

    if (row == col && List.generate(3, (i) => board[i][i]).every((element) => element == currentPlayer)) {
      return true;
    }

    if (row + col == 2 && List.generate(3, (i) => board[i][2 - i]).every((element) => element == currentPlayer)) {
      return true;
    }

    return false;
  }

  void resetGame() {
    setState(() {
      startNewGame();
    });
  }

  Widget buildResetButton() {
    return ElevatedButton(
      onPressed: resetGame,
      child: Text('Reset'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (winner != null) ? 'Player $winner wins!' : 'Current Player: $currentPlayer',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) {
              int row = index ~/ 3;
              int col = index % 3;
              return GestureDetector(
                onTap: () => makeMove(row, col),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text(
                      board[row][col],
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          buildResetButton(),
        ],
      ),
    );
  }
}
