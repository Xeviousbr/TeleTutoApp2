import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeleTudo App MotoBoys',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
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
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'User'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String user = _userController.text;
                String password = _passwordController.text;
                bool loginSuccessful = await API.VeLogin(user, password);
                if (loginSuccessful) {
                  print("Login bem-sucedido!");
                } else {
                  print("Falha no login.");
                }
              },
              child: Text("Login"),
            ),
            SizedBox(height: 32), // Adiciona um espaço entre os botões
            ElevatedButton(
              onPressed: () {
                // Ação para cadastrar um novo usuário
                // Você pode navegar para uma nova tela de cadastro ou abrir um diálogo, por exemplo
                print("Cadastrar novo usuário");
              },
              child: Text("Cadastrar Novo Usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
