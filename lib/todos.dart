import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './state/todos.dart';
import 'todo_card.dart';

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final value = ref.watch(todoListFuture);

        return value.when(
          loading: () => const Center(child: Text('Loading...')),
          error: (err, stack) => Center(
            child: Text(err.toString()),
          ),
          data: (todos) {
            return ListView(
              children: (todos as List).map((todo) {
                return TodoCard(todo);
              }).toList(),
            );
          },
        );
      },
    );
  }
}
