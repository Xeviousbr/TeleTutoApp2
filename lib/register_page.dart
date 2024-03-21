import 'package:flutter/material.dart';
import 'package:tele_tudo_app/HomePage.dart';
import 'package:tele_tudo_app/api.Dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnhController = TextEditingController();
  final _vehicleDocController = TextEditingController();
  final _pix = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _cnhController.dispose();
    _vehicleDocController.dispose();
    _pix.dispose();
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
            TextField(
              controller: _pix,
              decoration: InputDecoration(labelText: 'PIX'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String nome = _nameController.text;
                String email = _emailController.text;
                String senha = _passwordController.text;
                String cnh = _cnhController.text;
                String telefone = _phoneController.text;
                String documentoVeiculo = _vehicleDocController.text;
                String PIX = _pix.text;
                if (!validarNome(nome)) {
                  mostrarMensagem(
                      context, 'Por favor, insira o nome completo.');
                  return;
                }
                if (!validarEmail(email)) {
                  mostrarMensagem(
                      context, 'Por favor, insira um email válido.');
                  return;
                }
                if (!validarSenha(senha)) {
                  mostrarMensagem(context,
                      'A senha não pode ser vazia e deve ter no mínimo 6 caracteres.');
                  return;
                }
                if (!validarCNH(_cnhController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'CNH inválida. Por favor, verifique o número informado.')),
                  );
                  return; // Interrompe a execução se a CNH for inválida
                }
                bool Cadastrado = await API.registerUser(
                    nome, email, senha, telefone, cnh, documentoVeiculo, PIX);
                if (Cadastrado) {
                  print('Cadastro bem-sucedido');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  print('Falha no cadastro');
                  mostrarMensagem(context,
                      'Falha no cadastro. Por favor, tente novamente.');
                }
              },
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }

  bool validarNome(String nome) {
    return nome.isNotEmpty;
  }

  bool validarSenha(String senha) {
    return senha.isNotEmpty && senha.length >= 6;
  }

  bool validarEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  void mostrarMensagem(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  bool validarCNH(String cnh) {
    String cnhSemFormatacao = cnh.replaceAll(RegExp(r'\D'), '');
    if (cnhSemFormatacao.length != 11 || cnhSemFormatacao == "00000000000") {
      return false;
    }
    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cnhSemFormatacao[i]) * (9 - i);
    }
    int d1 = soma % 11;
    d1 = d1 < 10 ? d1 : 0;
    soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cnhSemFormatacao[i]) * (10 - i);
    }
    soma += d1 * 2;
    int d2 = soma % 11;
    d2 = d2 < 10 ? d2 : 0;
    return d1 == int.parse(cnhSemFormatacao[9]) &&
        d2 == int.parse(cnhSemFormatacao[10]);
  }
}
