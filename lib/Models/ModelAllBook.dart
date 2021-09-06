class ModelAllBook{
  
  int ?id;
  String ?cat_id;
  String ?book_name;
  String ?author_name;
  String? book_rating;

  ModelAllBook({this.id,this.cat_id,
    this.book_name,
    this.author_name,
    this.book_rating});

  factory ModelAllBook.fromJSON(Map map) {
    return ModelAllBook(
      id: map["id"],
      cat_id: map["cat_id"],
      book_name: map["book_name"],
      author_name: map["author_name"],
      book_rating: map["book_rating"],
    );
  }
}