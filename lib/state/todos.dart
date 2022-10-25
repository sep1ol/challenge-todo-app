import 'package:todo_app/models/todos.dart';
import 'package:todo_app/network/todos_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoListFuture = FutureProvider<List<Todo>>((ref) async {
  return fetchTodos();
});
