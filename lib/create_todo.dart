import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todo_app/network/constants/api_url.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/network/todos_request.dart';

class CreateTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
        shadowColor: Colors.black,
      ),
      body: TodoForm(),
    );
  }
}

class TodoForm extends StatefulWidget {
  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  String _task;
  String _priority;
  DateTime _date = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  createTodo() async {
    var newTodo = json.encode({
      "task": _task.toString(),
      "priority": _priority.toString(),
      "date": _date.toString()
    });

    var response = await http.post(
      Uri.parse('${api_url}/api/todos/create'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: newTodo,
    );
  }

  Widget _buildTodoField() {
    return TextFormField(
      cursorColor: Colors.red[600],
      decoration: InputDecoration(
        labelText: 'Task',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Todo field is Required.";
        }
      },
      onSaved: (String value) {
        setState(() {
          _task = value;
        });
      },
    );
  }

  Widget _buildDateField() {
    DateTime now = DateTime.now();
    return (Column(
      children: [
        SizedBox(height: 30),
        Text(_date == null
            ? '${now.day}/${now.month}/${now.year}'
            : '${_date.day}/${_date.month}/${_date.year}'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
          child: Text("Select date"),
          onPressed: () async {
            DateTime newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1930),
              lastDate: DateTime(2030),
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.dark(),
                  child: child,
                );
              },
            );

            if (newDate == null) return;
            setState(() => _date = newDate);
          },
        ),
      ],
    ));
  }

  Widget _buildPriorityField() {
    return TextFormField(
      initialValue: '1',
      decoration: InputDecoration(labelText: 'Priority (1-4)'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Priority is required.";
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        setState(() {
          _priority = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTodoField(),
                _buildPriorityField(),
                _buildDateField(),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    createTodo();
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => TodoApp()),
                    );
                    fetchTodos();
                  },
                  child: Container(
                    child: Text(
                      'Add task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    margin: EdgeInsets.all(15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                  ),
                ),
              ],
            )));
  }
}
