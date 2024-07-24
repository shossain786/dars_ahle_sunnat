// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class DBS_Screen extends StatefulWidget {
  const DBS_Screen({super.key});

  @override
  State<DBS_Screen> createState() => _DBS_ScreenState();
}

class _DBS_ScreenState extends State<DBS_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dars e Bahar e Shariat'),
      ),
    );
  }
}
