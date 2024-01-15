import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/main.dart';

void main() {
  testWidgets('Tic Tac Toe Game Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TicTacToeApp());

    // Verify that the initial text is displayed.
    expect(find.text('Current Player: X'), findsOneWidget);

    // Tap on a cell
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    // Verify that the text is updated after the first move
    expect(find.text('Current Player: O'), findsOneWidget);

    // Make a few moves to simulate a game
    await makeMoves(tester, [0, 1, 3, 4, 6]);

    // Verify that the game ends with a winner
    expect(find.text('Player X wins!'), findsOneWidget);

    // Tap the reset button
    await tester.tap(find.text('Reset'));
    await tester.pump();

    // Verify that the game is reset
    expect(find.text('Current Player: X'), findsOneWidget);
  });
}

Future<void> makeMoves(WidgetTester tester, List<int> moves) async {
  for (final move in moves) {
    await tester.tap(find.byType(GestureDetector).at(move));
    await tester.pump();
  }
}
