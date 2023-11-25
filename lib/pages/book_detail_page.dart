import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/book_model.dart';
import '../services/book_services.dart';

class BookDetailPage extends StatefulWidget {
  final BookModel book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool downloading = false;
  final BookService bookService = BookService(); // Crie uma instância do seu serviço

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Livro'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // Adicione lógica para iniciar a leitura do livro
              // (não implementado aqui)
            },
            child: CachedNetworkImage(
              imageUrl: widget.book.coverUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 20),
          Text('Título: ${widget.book.title}'),
          Text('Autor: ${widget.book.author}'),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                downloading = true;
              });

              try {
                await bookService.downloadBook(widget.book.downloadUrl, savePath: '/storage/emulated/0/Download/${widget.book.title}.epub');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Livro baixado com sucesso!')),
                );
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro durante o download: $error')),
                );
              } finally {
                setState(() {
                  downloading = false;
                });
              }
            },
            child: Text(downloading ? 'Baixando...' : 'Baixar Livro'),
          ),
        ],
      ),
    );
  }
}