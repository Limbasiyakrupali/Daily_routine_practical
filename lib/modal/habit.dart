class Habit {
  String title;
  String time;
  bool completed;
  String color;

  Habit({
    required this.title,
    required this.time,
    this.completed = false,
    this.color = 'grey',
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'time': time,
      'completed': completed,
      'color': color,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      title: map['title'],
      time: map['time'],
      completed: map['completed'],
      color: map['color'],
    );
  }
}
