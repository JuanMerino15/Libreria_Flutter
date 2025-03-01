import 'package:booksy_app/model/book.dart';
import 'package:booksy_app/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<BookshelfBloc, BookshelfState>(
      builder: (context, bookshelfState)  {

        if(bookshelfState.bookIds.isEmpty) {
      return Center(
        child: Text("Aun no tienes ningun libro en tu estante",
          style: Theme.of(context).textTheme.headlineMedium, 
          textAlign: TextAlign.center,       
        ));
    }
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
          ),
        itemCount: bookshelfState.bookIds.length,
        itemBuilder: (context, index) {
          return BookCoverItem(bookshelfState.bookIds[index]);
        }),
    );
  });
}
      }
    

class  BookCoverItem extends StatelessWidget {  
 final int _bookId;
 const  BookCoverItem(this._bookId, {super.key});
 
 @override
  Widget build(BuildContext context) {
    return Text("Libro y su id: $_bookId");
    // InkWell(
    //   onTap: (){},
    //   child: Ink.image(
    //     fit: BoxFit.fill,
    //     image: AssetImage(_book.coverUrl)));
  }}