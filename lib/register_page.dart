import 'package:flutter/material.dart';
import 'package:tele_tudo_app/HomePage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controladores para os campos de texto
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnhController = TextEditingController();
  final _vehicleDocController = TextEditingController();

  @override
  void dispose() {
    // É importante sempre descartar os controladores quando não forem mais necessários
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _cnhController.dispose();
    _vehicleDocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Motoboy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome Completo'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _cnhController,
              decoration: InputDecoration(labelText: 'CNH'),
            ),
            TextField(
              controller: _vehicleDocController,
              decoration: InputDecoration(labelText: 'Documento do Veículo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // String user = _userController.text;
                // String password = _passwordController.text;
                // Aqui você irá incluir a lógica para enviar os dados para a sua API
                // bool registrationSuccessful = await API.registerUser(user, password);
                bool registrationSuccessful = true;
                if (registrationSuccessful) {
                  print('Cadastro bem-sucedido');
                  // Redireciona para a HomePage
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  print('Falha no cadastro');
                  // Mostre uma mensagem de erro ou alerta
                }
              },
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}
