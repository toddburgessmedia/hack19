
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hack19/item.dart';
import 'package:http/http.dart' as http;


class StackOverFlowModel with ChangeNotifier {

  List<Item> _list = [];

  List<Item> getList() => _list;

  setList(List<Item> items) => _list = items;

  void queryStackOverflow() async {

    if (_list.length > 0) {
      return;
    }

    String url = "https://api.stackexchange.com/2.2/search?pagesize=20&order=desc&sort=activity&tagged=flutter&site=stackoverflow";
    http.Response response = await http.get(url);
    print(response.statusCode);
    final jsonData = json.decode(response.body);
    var rest = jsonData["items"] as List;

    _list = rest.map<Item>((json) => Item.fromJson(json)).toList();
    notifyListeners();
    }


}