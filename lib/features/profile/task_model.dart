class TaskModel {
  int? id;
  String title;
  int dateMillis; // date stored as epoch millis (start of day)
  int? timeMillis; // optional specific time as epoch millis
  int durationMinutes;
  int done; // 0 or 1
  int createdAtMillis;

  TaskModel({
    this.id,
    required this.title,
    required this.dateMillis,
    this.timeMillis,
    this.durationMinutes = 0,
    this.done = 0,
    required this.createdAtMillis,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
    id: map['id'] as int?,
    title: map['title'] as String,
    dateMillis: map['date'] as int,
    timeMillis: map['time'] as int?,
    durationMinutes: map['duration'] as int? ?? 0,
    done: map['done'] as int? ?? 0,
    createdAtMillis: map['createdAt'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'title': title,
    'date': dateMillis,
    'time': timeMillis,
    'duration': durationMinutes,
    'done': done,
    'createdAt': createdAtMillis,
  };
}
