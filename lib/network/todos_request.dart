import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'constants/api_url.dart';
import 'package:todo_app/models/todos.dart';

List<Todo> parseTodos(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Todo> todos = list.map((todo) => Todo.fromJson(todo)).toList();

  return todos;
}

Future<List<Todo>> fetchTodos() async {
  final response = await http.get(Uri.parse('${api_url}/api/todos'));

  if (response.statusCode == 200) {
    return compute(parseTodos, response.body);
  } else {
    throw Exception(
      "Unable to fetch tasks from database***${response.body.toString()}",
    );
  }
}
