import 'package:booksy_app/model/book_category.dart';
import 'package:booksy_app/utils.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BookCategoriesGrid();
  }
}

class BookCategoriesGrid extends StatelessWidget {
  const BookCategoriesGrid({super.key});

  static final List<BookCategory> _categories = [
    BookCategory(id: 1, name: "Ciencia ficción", colorBg: "#A9CCE3"),
    BookCategory(id: 2, name: "Aventura", colorBg: "#C5F0B3"),
    BookCategory(id: 3, name: "Filosofía", colorBg: "#F0B3E1"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin : const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: _categories.length,
        gridDelegate: 
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return TileCategory(_categories[index]);
      
        }
        ),
    );
  }

}

class TileCategory extends StatelessWidget {
  final BookCategory _category;
  const TileCategory(this._category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          _navigateToBooksWithCategory();
        },
        child: Container(
          alignment: AlignmentDirectional.center ,
          
          decoration: BoxDecoration(borderRadius:  BorderRadius.circular(4.0),
          color: hexToColor(_category.colorBg),
          ),
          child: Text(_category.name, 
          style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ));
    
  }
  
  void _navigateToBooksWithCategory() {
    // Navegar a la pantalla de lista de libros de la categoria

  }
}