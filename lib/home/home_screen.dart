import 'package:booksy_app/book_details/book_details_screen.dart';
import 'package:booksy_app/model/book.dart';
import 'package:booksy_app/services/books_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> _books = [];
  @override
  void initState(){
    super.initState();
    _getLastBooks();
  }

  void _getLastBooks() async{
    var lastBooks = await BooksService().getLastBooks();
    setState(() {
      _books = lastBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    var showProgress = _books.isEmpty;
    var listLength = showProgress ? 3 : _books.length + 2;
    return Container(
      margin: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: listLength, 
        itemBuilder:  (context,index){
          if (index == 0) {
            return const HeaderWidget();
          }
          if (index == 1) {
            return const ListItemHeader();
          }
          if(showProgress){
            return const Padding(
              padding:  EdgeInsets.only(top: 50),
              child:  Center(child: CircularProgressIndicator()),
            );
      
          }
          return ListItemBook(_books[index - 2]);
      
      }
      ),
    );
  }
}
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/images/header.webp'));
  }

}
class ListItemHeader extends StatelessWidget {
  const ListItemHeader({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 5),
      child: const Text("Últimos Libros", style: TextStyle(fontSize: 20))
      );
  }
}

class ListItemBook extends StatelessWidget {
  final Book _book;
  const ListItemBook(this._book, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
   return Card(
     child: SizedBox(
      height: 170,
       child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          _openBookDetails(context, _book);

        } ,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Image.asset(_book.coverUrl),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Flexible(child: Text(_book.title, style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 18))),
                const SizedBox(height: 5,),
                Flexible(child: Text(_book.author, style: Theme.of(context).textTheme.titleMedium)),
                const SizedBox(height: 15,),
                Flexible(child: Text(_book.description, maxLines: 4, overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyMedium)),
              ],)
              )
              
            ],
           ),
         ),
       ),
     ),
   );
  }
  
  void _openBookDetails(BuildContext context, Book book) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => BookDetailsScreen(book)));
  }
}