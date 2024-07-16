import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tele_tudo_app/HomePage.dart';
import 'package:tele_tudo_app/api.dart';
import 'package:tele_tudo_app/register_page.dart';
import 'package:universal_platform/universal_platform.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TeleTudo App MotoBoys',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'User'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String user = _userController.text;
                String password = _passwordController.text;
                double lat = 0.0;
                double lon = 0.0;
                print("Antes do Login.");
                bool loginSuccessful =
                    await API.veLogin(user, password, lat, lon);
                if (loginSuccessful) {
                  print("Depois do Login.");
                  getTokenAndHandle();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else {
                  print("Falha no login.");
                }
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text("Cadastrar Novo Usuário"),
            ),
          ],
        ),
      ),
    );
  }

  void getTokenAndHandle() {
    if (UniversalPlatform.isAndroid) {
      FirebaseMessaging.instance.getToken().then((token) {
        if (token != null) {
          print("Token recebido: $token");
          API.sendTokenToServer(token);
        } else {
          print("Token é null");
          showSnackbar("Falha ao obter token: Token é nulo.");
        }
      }).catchError((error) {
        print("Erro ao obter o token: $error");
        showSnackbar("Erro ao obter token: $error");
      });
    } else {
      String fakeToken = "fake_" + Random().nextInt(999999).toString();
      print("Token falso gerado: $fakeToken");
      API.sendTokenToServer(fakeToken);
    }
  }

  void showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar); // Modificado para usar ScaffoldMessenger
  }
}
