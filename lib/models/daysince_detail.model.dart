const String daysinceDetailTableName = 'daysince_detail';

class DaysinceDetailFields {
  static final List<String> columns = [id, description, startingDate];

  static const String id = '_id';
  static const String description = 'description';
  static const String startingDate = 'startingDate';
}

class DaysinceDetail {
  final int? id;
  final String description;
  final DateTime startingDate;

  const DaysinceDetail(
      {this.id, required this.description, required this.startingDate});

  static DaysinceDetail fromJson(Map<String, Object?> json) => DaysinceDetail(
        id: json[DaysinceDetailFields.id] as int?,
        description: json[DaysinceDetailFields.description] as String,
        startingDate:
            DateTime.parse(json[DaysinceDetailFields.startingDate] as String),
      );

  Map<String, Object?> toJson() => {
        DaysinceDetailFields.id: id,
        DaysinceDetailFields.description: description,
        DaysinceDetailFields.startingDate: startingDate.toIso8601String(),
      };

  DaysinceDetail copy({int? id, String? description, DateTime? startingDate}) =>
      DaysinceDetail(
          id: id ?? this.id,
          description: description ?? this.description,
          startingDate: startingDate ?? this.startingDate);
}
