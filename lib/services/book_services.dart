import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/book_model.dart';

class BookService {

  Future<List<BookModel>> fetchBooks() async {
    const String jsonUrl = 'https://escribo.com/books.json';

    try {
      final response = await http.get(Uri.parse(jsonUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonBooks = json.decode(response.body);
        List<BookModel> books = jsonBooks.map((jsonBook) {
          return BookModel(
            id: jsonBook['id'],
            title: jsonBook['title'],
            author: jsonBook['author'],
            coverUrl: jsonBook['cover_url'],
            downloadUrl: jsonBook['download_url'],
          );
        }).toList();

        return books;
      } else {
        throw Exception('Falha ao carregar os livros. Código de status: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao obter dados: $error');
      rethrow;
    }
  }

  Future<void> downloadBook(String downloadUrl, {String savePath = '/storage/emulated/0/Download/'}) async {
    try {
      final response = await http.get(Uri.parse(downloadUrl));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        print('teste teste $directory');

        File file = File(savePath);
        await file.writeAsBytes(response.bodyBytes);

        print('Download concluído. Arquivo salvo em: $savePath');
      } else {
        throw Exception('Falha ao baixar o livro. Código de status: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro durante o download: $error');
      rethrow;
    }
  }
}
