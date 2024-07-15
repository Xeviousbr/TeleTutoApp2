import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Tentando inicializar o Firebase diretamente
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB-ABCDE12FghIJKLMnoPQRsTuVwxyz",
        authDomain: "entregatudo-e695a.firebaseapp.com",
        projectId: "entregatudo-e695a",
        storageBucket: "entregatudo-e695a.appspot.com",
        messagingSenderId: "393650997319",
        appId: "G-Q7J49LY80Q",
      ),
    );
  } catch (e) {
    // Capturando qualquer exceção que possa ocorrer durante a inicialização e imprimindo
    print("Erro ao inicializar o Firebase: $e");
  }
  runApp(const MyApp());
}

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
