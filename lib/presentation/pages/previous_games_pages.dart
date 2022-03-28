import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/games_controller.dart';

class PreviousGamesPage extends ConsumerWidget {
  const PreviousGamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final games = ref.watch(getGamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Que pasa '),
      ),
      body: games.when(
        data: (data) => data.isEmpty
            ? const Center(
                child: Text('No hay partidas guardadas'),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(data[index].id),
                ),
              ),
        error: (error, s) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
