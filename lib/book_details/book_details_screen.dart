import 'package:booksy_app/model/book.dart';
import 'package:booksy_app/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book _book;
  const BookDetailsScreen(this._book, {super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del libro"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          BookCoverWidget(_book.coverUrl),
          BookInfoWidget(_book.title, _book.author, _book.description),
          BookActionsWidget(_book.id),
        ],
        ),
      ),
    );
  }
}

class BookActionsWidget extends StatelessWidget{
  final String bookId;
  const BookActionsWidget(this.bookId, {super.key});

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<BookshelfBloc, BookshelfState>(
      builder: (context, bookshelfState)  {
        var action = () => _addToBookShelf(context, bookId );
        var label = "Agregar a mi estante";
        var color = Colors.green;

        if (bookshelfState.bookIds.contains(bookId)){
          action = () => _removeFromBookShelf(context, bookId);
          label = "Quitar de mi estante";
          color = Colors.amber;
        }
         return ElevatedButton(
            onPressed: action,
            style: ElevatedButton.styleFrom(backgroundColor: color), 
            child: Text(
              label, 
              style: const TextStyle(color: Colors.white), // Aquí está el cambio correcto
            ),
          );

        }); 
      
  }
  
  void _addToBookShelf(BuildContext context, String bookId) {
    var bookshelfBloc = context.read<BookshelfBloc>();
    bookshelfBloc.add(AddBookToBookShelf(bookId));
  }

    void _removeFromBookShelf(BuildContext context, String bookId) {
    var bookshelfBloc = context.read<BookshelfBloc>();
    bookshelfBloc.add(RemoveBookFromBookShelf(bookId));
  }

}

class BookInfoWidget extends StatelessWidget{
  final String title;
  final String author;
  final String description;

  const BookInfoWidget( this.title, this.author, this.description,  {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        Text(title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),),
        const SizedBox(height: 5,),
        Text(author, style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: 20,),
        Text(description, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),),
      ],
      ),
    );
  }

}

class BookCoverWidget extends StatelessWidget {
  final String _coverUrl;
  const BookCoverWidget(this._coverUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: 230,
      height: 300, // Añadir un tamaño fijo para que todas las imágenes tengan el mismo tamaño
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 20,
          ),
        ],
      ),
      child: _getImageWidget(_coverUrl),
    );
  }

  _getImageWidget(String coverUrl) {
    if (coverUrl.startsWith("http")) {
      return Image.network(coverUrl, fit: BoxFit.cover); 
    } else {
      return Image.asset(coverUrl, fit: BoxFit.cover);  
    }
  }
}
