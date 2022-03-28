import 'package:flutter/material.dart';

class PlayersHeaderWidget extends StatelessWidget {
  const PlayersHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            height: 100,
            child: const Center(child: Text('Player 1')),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            height: 100,
            child: const Center(child: Text('Player 2')),
          ),
        ),
      ],
    );
  }
}
