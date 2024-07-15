import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tele_tudo_app/api.Dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;

  @override
  void initState() {
    chamaHeartbeat();
    super.initState();
    _startHeartbeatTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('teletudo App'),
        centerTitle: true,
      ),
    );
  }

  void _startHeartbeatTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      chamaHeartbeat();
    });
  }

  Future<void> chamaHeartbeat() async {
    await API.sendHeartbeat();
  }
}
