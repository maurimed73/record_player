import 'package:flutter/material.dart';

class MissaSamples extends StatefulWidget {
  const MissaSamples({super.key});

  @override
  State<MissaSamples> createState() => _MissaSamplesState();
}

class _MissaSamplesState extends State<MissaSamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Página de samples Missa',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
