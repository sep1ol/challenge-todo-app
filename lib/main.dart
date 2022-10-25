import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'todos.dart';
import 'create_todo.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
          shadowColor: Colors.black,
        ),
        body: TodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateTodo()),
            );
          },
          child: Icon(
            IconData(0xe050, fontFamily: 'MaterialIcons'),
            size: 45,
          ),
          backgroundColor: Colors.red[600],
        ),
      );
    });
  }
}
