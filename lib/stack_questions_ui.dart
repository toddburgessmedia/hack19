import 'package:flutter/material.dart';
import 'package:flutter_hack19/stack_overflow_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StackQuestionsUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<StackOverFlowModel>(context);
    model.queryStackOverflow();
    final newList = model.getList();
      return new Container(
          child: new ListView.builder(
            itemCount: newList.length,
            itemBuilder: (context, index) {
              return Container(
                color: (index %2 == 0) ? Colors.blueGrey[100] : Colors.white,
                child: ListTile(
                  title: Text(newList[index].title),
                  onTap: () {launch(newList[index].link);},
                ),
              );
            },
          ));
    }
}

