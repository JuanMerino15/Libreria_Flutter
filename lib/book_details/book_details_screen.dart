import 'package:booksy_app/model/book.dart';
import 'package:flutter/material.dart';

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
          ElevatedButton(onPressed: () {}, child: const Text("Acción"),)
        ],
        ),
      ),
    );
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
    child: Image.asset(_coverUrl),
    decoration: BoxDecoration(boxShadow: [BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 10,
      blurRadius: 20,
    ),
    
    ],
    
    )
    
    );
    
  }

}