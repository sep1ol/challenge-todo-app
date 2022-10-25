import 'package:flutter/material.dart';
import 'package:todo_app/models/todos.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/network/constants/api_url.dart';

class TodoCard extends StatefulWidget {
  Todo todo;
  String dateFormatted;

  TodoCard(this.todo) {
    dateFormatted = DateFormat.yMMMMd().format(DateTime.parse(todo.date));
  }

  @override
  State<TodoCard> createState() => _TodoCardState(todo, dateFormatted);
}

class _TodoCardState extends State<TodoCard> {
  Todo todo;
  String dateFormatted;

  _TodoCardState(this.todo, this.dateFormatted);

  completeTodo() async {
    var response = await http.put(
      Uri.parse('${api_url}/api/todos/complete/${todo.id}'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        todo.completed = true;
      });
    }
  }

  deleteTodo() async {
    var response = await http.delete(
      Uri.parse('${api_url}/api/todos/delete/${todo.id}'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        todo = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return todo != null
        ? (Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ListTile(
              onTap: () {
                completeTodo();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              tileColor: Colors.white,
              leading: Icon(
                todo.completed
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Colors.red[600],
              ),
              title: Text(
                todo.task,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  decoration:
                      todo.completed ? TextDecoration.lineThrough : null,
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
                    deleteTodo();
                  },
                ),
              ),
            ),
          ))
        : (Text(' '));
  }
}
