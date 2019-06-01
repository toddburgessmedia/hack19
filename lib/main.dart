import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'stackoverflow_model.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Github Hack 19 App',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new MyHomePage(title: 'Flutter Hack19 Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Item> list;
  int size = 0;

  void _queryStackOverflow() async {

    String url = "https://api.stackexchange.com/2.2/search?pagesize=20&order=desc&sort=activity&tagged=flutter&site=stackoverflow";
    http.Response response = await http.get(url);

    print(response.statusCode);
    final jsonData = json.decode(response.body);
    var rest = jsonData["items"] as List;
    print("Hello world");
    print(rest);

    list = rest.map<Item>((json) => Item.fromJson(json)).toList();

    setState(() {
//      list = rest.map<Item>((json) => Item.fromJson(json)).toList();
    });


  }

  @override
  Widget build(BuildContext context) {

    if (list == null) {
      _queryStackOverflow();
    }
    print("hello");

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body:
        ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index].title),
              onTap: () {launch(list[index].link);} ,
            );
          },
        ));
  }
}
