import 'package:flutter/material.dart';
import 'package:todoapp/models/global.dart';

class IntrayTodo extends StatelessWidget {
  final String title;
  final String keyValue;
  IntrayTodo({this.keyValue,this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      margin: EdgeInsets.only(bottom: 10.0),
      height: 100.0,
      decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
            ),
          ]),
      child: Row(
        children: <Widget>[
          Radio(),
          Column(
            children: <Widget>[
              Text(
                title,
                style: darkTodoTitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
