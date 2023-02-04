import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    int? idEmpresa = prefs.getInt('idEmpresa');
    print("idEmpresa = " + idEmpresa.toString());
  }
}
