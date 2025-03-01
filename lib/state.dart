import 'package:flutter_bloc/flutter_bloc.dart';

class BookshelfState {
  List<int> bookIds;
  BookshelfState(this.bookIds);
}

abstract class BookshelfEvent {
  const BookshelfEvent();
}

class AddBookToBookShelf extends BookshelfEvent{
  final int bookId;
   AddBookToBookShelf(this.bookId);

}

class RemoveBookFromBookShelf extends BookshelfEvent {
  final int bookId;
  const RemoveBookFromBookShelf(this.bookId);
}

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState>{
  BookshelfBloc(super.initialState){
    on<AddBookToBookShelf>((event, emit){
      state.bookIds.add(event.bookId);
      emit(BookshelfState(state.bookIds));
    });
    on<RemoveBookFromBookShelf>((event, emit){
      state.bookIds.remove(event.bookId);
      emit(BookshelfState(state.bookIds));
    });
  }
}