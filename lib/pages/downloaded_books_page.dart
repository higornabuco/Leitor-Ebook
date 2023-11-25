import 'dart:io';import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedBooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder<List<File>>(
        future: _getDownloadedBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum livro baixado.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Livro ${index + 1}'),
                  onTap: () {
                    // Adicione a lógica para abrir e exibir o livro
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<File>> _getDownloadedBooks() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      Directory downloadsDirectory = Directory('${documentsDirectory.path}/downloads');

      if (!downloadsDirectory.existsSync()) {
        return [];
      }

      return downloadsDirectory.listSync().whereType<File>().toList();
    } catch (error) {
      print('Erro ao obter livros baixados: $error');
      return [];
    }
  }
}