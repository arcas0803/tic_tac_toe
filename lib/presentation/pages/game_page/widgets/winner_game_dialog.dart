import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/presentation/widgets/rounded_button_widget.dart';

class WinnerGameDialog extends StatefulWidget {
  final void Function() onClose;
  final void Function() onReplayGame;
  final PlayerEntity winner;

  const WinnerGameDialog({
    Key? key,
    required this.onClose,
    required this.onReplayGame,
    required this.winner,
  }) : super(key: key);

  @override
  State<WinnerGameDialog> createState() => _WinnerGameDialogState();
}

class _WinnerGameDialogState extends State<WinnerGameDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => _confettiController.play(),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Align _buildConfetti({required double blastDirectionality}) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: const Size(30, 30),
        shouldLoop: false,
        confettiController: _confettiController,
        blastDirection: blastDirectionality,
        blastDirectionality: BlastDirectionality.directional,
        maxBlastForce: 20, // set a lower max blast force
        minBlastForce: 8, // set a lower min blast force
        emissionFrequency: 1,
        gravity: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          _buildConfetti(blastDirectionality: math.pi),
          _buildConfetti(blastDirectionality: math.pi / 4),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/img/throphy.png",
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(15),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  child: Text(
                    "You won: ${widget.winner.name}",
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButtonWidget(
                    onPressed: () => widget.onClose(),
                    title: "Close",
                  ),
                  RoundedButtonWidget(
                    onPressed: widget.onReplayGame,
                    title: "New Game",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
