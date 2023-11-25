import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../models/book_model.dart';
import '../services/book_services.dart';
import 'book_detail_page.dart';

class BookshelfPage extends StatefulWidget {
  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> with SingleTickerProviderStateMixin {
  final BookService _bookService = BookService();
  late TabController _tabController;
  final Set<int> favoriteBookIds = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estante Virtual'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Livros'),
            Tab(text: 'Favoritos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTab('Livros'),
          _buildTab('Favoritos'),
        ],
      ),
    );
  }

  Widget _buildTab(String tabName) {
    return FutureBuilder<List<BookModel>>(
      future: _bookService.fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum livro encontrado.'));
        } else {
          // Filtra os livros baseados na aba
          final List<BookModel> filteredBooks = (tabName == 'Livros')
              ? snapshot.data!
              : snapshot.data!.where((book) => favoriteBookIds.contains(book.id)).toList();

          return ListView.builder(
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              final book = filteredBooks[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                onTap: () {
                  if (tabName == 'Livros') {
                    _navigateToBookDetailPage(book);
                  } else {
                    // Aba "Favoritos" - Pode adicionar lógica adicional aqui se necessário
                  }
                },
              );
            },
          );
        }
      },
    );
  }

  void _navigateToBookDetailPage(BookModel book) async {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../models/book_model.dart';
// import '../services/book_services.dart';
// import 'book_detail_page.dart';
//
// class BookshelfPage extends StatefulWidget {
//   @override
//   _BookshelfPageState createState() => _BookshelfPageState();
// }
//
// class _BookshelfPageState extends State<BookshelfPage> {
//   final BookService _bookService = BookService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Estante Virtual'),
//       ),
//       body: FutureBuilder<List<BookModel>>(
//         future: _bookService.fetchBooks(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erro: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('Nenhum livro encontrado.'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(snapshot.data![index].title),
//                   subtitle: Text(snapshot.data![index].author),
//                   onTap: () {
//                     _navigateToBookDetailPage(snapshot.data![index]);
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   void _navigateToBookDetailPage(BookModel book) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BookDetailPage(book: book),
//       ),
//     );
//   }
// }