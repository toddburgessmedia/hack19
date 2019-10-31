
class Item {
  String title;
  String link;

  Item({
    this.title,
    this.link
  });

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    return Item(
        title: parsedJson['title'],
        link: parsedJson['link']
    );
  }
}