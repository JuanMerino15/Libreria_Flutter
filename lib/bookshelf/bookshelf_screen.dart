import 'package:booksy_app/add_book/add_book_screen.dart';
import 'package:booksy_app/book_details/book_details_screen.dart';
import 'package:booksy_app/model/book.dart';
import 'package:booksy_app/services/books_services.dart';
import 'package:booksy_app/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



class BookshelfScreen extends StatelessWidget {
  BookshelfScreen({super.key});
  InterstitialAd? _ad;
  @override
  Widget build(BuildContext context) {
    InterstitialAd.load(adUnitId: "ca-app-pub-3940256099942544/1033173712",
    request: const AdRequest(), adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad){
        print("Ad esta cargado");
        _ad = ad;
        _ad!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            _navigateToAddNewBookScreen(context);
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            print(error);
             _navigateToAddNewBookScreen(context);
          }
        );
      }, 
      onAdFailedToLoad: (error){
        print(error);
       
      }));
      return BlocBuilder<BookshelfBloc, BookshelfState>(
      builder: (context, bookshelfState)  {
        var emptyListWidget = Center(
        child: Text("Aun no tienes ningun libro en tu estante",
          style: Theme.of(context).textTheme.headlineMedium, 
          textAlign: TextAlign.center,       
        ),
        );
        var mainWidget = bookshelfState.bookIds.isEmpty 
        ? emptyListWidget 
        :  MyBooksGrid(bookshelfState.bookIds);
    return Column(
      children: [
        Expanded(child: mainWidget),
        ElevatedButton(onPressed: () {
          if (_ad != null) {
            _ad!.show();
          }else {
          _navigateToAddNewBookScreen(context);
          }
          
        }, child: const Text("Agregar nuevo libro"))
      ],
    );
  });
}

  void _navigateToAddNewBookScreen(BuildContext context) {
    Navigator.push(context, 
    MaterialPageRoute(
      builder: (context) => const AddBookScreen(),));
  }
      }

class MyBooksGrid extends StatelessWidget {
  final List<String> bookIds;
  const MyBooksGrid(this.bookIds, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: bookIds.length,
          itemBuilder: (context, index) {
            return BookCoverItem(bookIds[index]);
          }),
    );
  }
}

class BookCoverItem extends StatefulWidget {
  final String _bookId;

  const BookCoverItem(this._bookId, {Key? key}) : super(key: key);

  @override
  State<BookCoverItem> createState() => _BookCoverItemState();
}

class _BookCoverItemState extends State<BookCoverItem> {
  Book? _book;

  @override
  void initState() {
    super.initState();
    _getBook(widget._bookId);
  }

  void _getBook(String bookId) async {
    var book = await BooksService().getBook(bookId);
    setState(() {
      _book = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_book == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return InkWell(
      onTap: () {
        _openBookDetails(_book!, context);
      },
      child: Ink.image(
        fit: BoxFit.fill,
        image: _getImageWidget(_book!.coverUrl),  
      ),
    );
  }

  _openBookDetails(Book book, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book),
      ),
    );
  }

 
  _getImageWidget(String coverUrl) {
    if (coverUrl.startsWith("http")) {
      return NetworkImage(coverUrl);  
    } else {
      return AssetImage(coverUrl);   
    }
  }
}
