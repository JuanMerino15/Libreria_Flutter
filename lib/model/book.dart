class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
  });

  toJson(){
      throw UnimplementedError();
    }
    
  factory Book.fromJson(String id, Map<String, dynamic> json) {
    return Book(
      id: id,
      title: json['name'] as String, 
      author: json['author'] as String,
      description: json['summary'] as String,
      coverUrl: json['coverUrl'] as String,
  
    );
   
  }
}
