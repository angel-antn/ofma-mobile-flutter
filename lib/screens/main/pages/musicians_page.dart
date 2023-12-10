import 'package:flutter/material.dart';

class MusicianPage extends StatelessWidget {
  const MusicianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Músicos'),
      ),
    );
  }
}
