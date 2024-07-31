import 'package:cinemacuenca/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: Text('casi casi'),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
