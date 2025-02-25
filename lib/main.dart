import 'package:booksy_app/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BooksyApp());
}

class BooksyApp extends StatelessWidget {
  const BooksyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booksy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, 
          primary: Colors.green, 
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,  
        ),
      ),
      home: const BottomNavigationWidget(),
    );
  }
}

class BottomNavigationWidget extends StatefulWidget{
  const BottomNavigationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationWidgetState(); 
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget>{
  int _selectedIndex = 0;
  static const List<Widget> _sections = [HomeScreen(), Text('Biblioteca'),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booksy')),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon:  Icon(Icons.home), 
          label: 'Inicio'),
        BottomNavigationBarItem(
          icon:  Icon(Icons.local_library),
          label: 'Biblioteca'),
      ],
       currentIndex: _selectedIndex,
       onTap: _onItemTapped,
       
       ),
       body: _sections[_selectedIndex]
    );
  }


void _onItemTapped (int index){
  setState((){
    _selectedIndex = index;
  });
}
}
