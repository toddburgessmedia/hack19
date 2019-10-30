import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hack19/stackoverflow_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


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
            return Container(
              color: (index %2 == 0) ? Colors.blueGrey[100] : Colors.white,
              child: ListTile(
                title: Text(newlist[index].title),
                onTap: () {launch(newlist[index].link);},
              ),
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