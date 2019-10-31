import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hack19/stack_overflow_model.dart';
import 'package:flutter_hack19/stack_questions_ui.dart';
import 'package:flutter_hack19/item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body: ChangeNotifierProvider<StackOverFlowModel>(
            builder: (_) => StackOverFlowModel(),
            child: StackQuestionsUI(),
          ),
    ),);
    }

  }
}
