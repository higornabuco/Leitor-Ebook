# Leitor de Ebook

 Esse projeto tem como objetivo criar um Leitor de arquivos do tipo EPUB. Como ele você consegue fazer download dos livros de uma lista JSON e le-los no proprio app.
 Porém eu não consegui concluí-lo 100%. Abaixo vou descrever as dificuldades que eu tive.

* A maior dificuldade que eu tive foi de usar a dependencia `vocsy_epub_viewer`, que está disponível no https://pub.dev/.

* Consegui criar a lista dos livros com uma página de detalhes do livro, mas não consegui implementar um botão para salvar como favoritos.

* A home onde fica a biblioteca de livros não ficou como eu queria. Era para ser duas colunas com cards com a cover dos livros. No lugar dessa vizualização ficou uma ListView, que não ficou tão ruim pelo fato de ao clicar no nome do livro e autor, ele te leva para página de detalhes, e lá está a cover do livro e a opção de baixa-lo.

* E por ultimo, problema ao baixar o livro em um dispositivo fisico. Eu consegui salvar os livros baixados no diretorio '/storage/emulated/0/Download'. No emulador funciona porque existe esse diretorio nele, mas no dispositivo fisico é outro diretorio.


## Conclusão

Ainda vou continuar trabalhando nesse projeto porque eu gostei e quero ver funcionando. O fato de eu não ter tido muito tempo e conhecimento limitado sobre alguams coisas, fez com que eu não conseguisse concluir 100% do app.

Vou deixar o apk disponivel para download aqui no repositorio.



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
