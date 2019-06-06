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

  List<Item> list = [];
  bool loaded = true;

  Future<List<Item>> _queryStackOverflow() async {

    String url = "https://api.stackexchange.com/2.2/search?pagesize=20&order=desc&sort=activity&tagged=flutter&site=stackoverflow";
    http.Response response = await http.get(url);

    print(response.statusCode);
    final jsonData = json.decode(response.body);
    var rest = jsonData["items"] as List;

    return rest.map<Item>((json) => Item.fromJson(json)).toList();
  }

  Widget StackQuestionsUI(List<Item> newlist) {
    return new Container(
      child: new ListView.builder(
        itemCount: newlist.length,
        itemBuilder: (context, index) {
          return new ListTile(
            title: Text(newlist[index].title),
            onTap: () {launch(newlist[index].link);},
          );
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new FutureBuilder<List<Item>>(
              future: _queryStackOverflow(),
              builder: (context,snapshot) {
                return snapshot.hasData
                    ? StackQuestionsUI(snapshot.data)
                    : new Center(child: CircularProgressIndicator());
              }
        )
        ),
    );
  }
}
