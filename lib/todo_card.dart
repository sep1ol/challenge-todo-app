import 'package:flutter/material.dart';
import 'package:todo_app/models/todos.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  String dateFormatted;

  TodoCard(this.todo) {
    dateFormatted = DateFormat.yMMMMd().format(DateTime.parse(todo.date));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // COMPLETE TASK
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.completed ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.red[600],
        ),
        title: Text(
          todo.task,
          style: TextStyle(
            fontSize: 19,
            color: Colors.black,
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(dateFormatted,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            )),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print('Clicked on delete icon');
              // onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////
// WIDGET ROWS

class CompletionButton extends StatelessWidget {
  bool completed;

  CompletionButton(this.completed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        onPressed: () {},
        iconSize: 40,
        style: IconButton.styleFrom(
          side: BorderSide(width: 4000),
        ),
        icon: completed
            ? Icon(
                IconData(0xef46, fontFamily: 'MaterialIcons'),
              )
            : Icon(
                IconData(0xef45, fontFamily: 'MaterialIcons'),
              ),
      ),
      margin: EdgeInsets.only(left: 5, right: 15),
    );
  }
}

class TodoDate extends StatelessWidget {
  final String date;

  TodoDate(this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (Text(date)),
      margin: EdgeInsets.only(left: 5, right: 5),
    );
  }
}
