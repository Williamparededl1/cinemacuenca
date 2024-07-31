import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('favoritos vista'),
      ),
      body: const Center(
        child: Text('Tus Peliculas Favoritas'),
      ),
    );
  }
}
