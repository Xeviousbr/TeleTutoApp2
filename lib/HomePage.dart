import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Inicializa();
    return Scaffold(
      appBar: AppBar(
        title: Text('teletudo App'),
        centerTitle: true,
      ),
    );
  }

  Future<void> Inicializa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('ID');
  }

  void _startHeartbeatTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      // await API.sendHeartbeat(); // ERRO AQUI
    });
  }
}
