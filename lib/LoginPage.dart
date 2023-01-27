import 'dart:convert';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'api.dart';
import 'package:tele_tudo_app/HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user = '';
  String password = '';
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Faça seu login",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 35,
          ),
          TextField(
            onChanged: (text) {
              user = text;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Usuário:",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (text) {
              password = text;
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Senha:",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              API.VeLogin(user, password).then((logou) {
                setState(() {
                  if (logou) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    debugPrint("login invalido");
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              });
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  final snackBar = const SnackBar(
      content: Text("Usuário ou senha incorretos", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);
}
