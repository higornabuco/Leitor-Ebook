import 'package:flutter/material.dart';
import 'pages/bookshelf_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obter os dados antes de iniciar o aplicativo
  try {
  } catch (e) {
    // Lida com erros na obtenção de dados, por exemplo, mostrando uma mensagem de erro
    print('Erro ao obter dados: $e');
    return;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu Aplicativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookshelfPage(),
    );
  }
}