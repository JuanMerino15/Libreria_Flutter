import 'package:booksy_app/model/book.dart';

class BooksService{
static final List<Book> books = [
  Book(
    id: 1,
    title: "Essentialism: The disciplined pursuit of less",
    author: "Greg Mckeown",
    description: "Have you ever found yourself struggling with information overload?",
    coverUrl: "assets/images/esencialismo1.jpg",
  ),
  Book(
    id: 2,
    title: "Einstein: His Life and Universe",
    author: "Walter Isaacson",
    description: "Einstein was a rebel and nonconformist from boyhood days.",
    coverUrl: "assets/images/Book1.webp",
  ),
  Book(
    id: 3,
    title: "Atomic Habits",
    author: "James Clear",
    description: "A guide on how small habits can lead to remarkable results.",
    coverUrl: "assets/images/atomic_habits.jpg",
  ),
  Book(
    id: 4,
    title: "The Pragmatic Programmer",
    author: "Andrew Hunt & David Thomas",
    description: "Tips and techniques for software development and career growth.",
    coverUrl: "assets/images/pragmatic_programmer.jpg",
  ),
  Book(
    id: 5,
    title: "Deep Work",
    author: "Cal Newport",
    description: "Rules for focused success in a distracted world.",
    coverUrl: "assets/images/deep_work.jpg",
  ),
];

  Future<List<Book>>getLastBook() async {
    // var books = await api.getBooks();
    return Future.delayed(const Duration(seconds:3))
    .then((value) => Future.value(books.sublist(0,3)));
  }

  
  Future<Book>getBook(int bookId) async {
    // var books = await api.getBooks();
    return Future.delayed(const Duration(seconds:3))
    .then((value) => Future.value(books.firstWhere((bookElement) => bookElement.id == bookId)));
  }
}