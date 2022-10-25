class Todo {
  String task;
  String description;
  String date;
  int priority;
  int id;
  bool completed;

  Todo({
    this.task,
    this.description,
    this.date,
    this.priority,
    this.id,
    this.completed,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    description = json['description'];
    date = json['date'];
    priority = json['priority'];
    id = json['id'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = this.task;
    data['description'] = this.description;
    data['date'] = this.date;
    data['priority'] = this.priority;
    data['id'] = this.id;
    data['completed'] = this.completed;
    return data;
  }
}
