import 'package:cinemacuenca/config/constants/enviroment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(' la llve es ${Enviroment.theMovieDbKey}'),
      ),
    );
  }
}
