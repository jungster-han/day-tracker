final String daysinceTable = 'daysinces';

class DaysinceFields {
  static final List<String> values = [
    /// Add all fields
    id, description, startDate
  ];

  static final String id = '_id';
  static final String description = 'description';
  static final String startDate = 'startDate';
}

class Daysince {
  final int? id;
  final String description;
  final DateTime startDate;

  const Daysince({
    this.id,
    required this.description,
    required this.startDate,
  });

  Daysince copy({
    int? id,
    String? description,
    DateTime? startDate,
  }) =>
      Daysince(
        id: id ?? this.id,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
      );

  static Daysince fromJson(Map<String, Object?> json) => Daysince(
        id: json[DaysinceFields.id] as int?,
        description: json[DaysinceFields.description] as String,
        startDate: DateTime.parse(json[DaysinceFields.startDate] as String),
      );

  Map<String, Object?> toJson() => {
        DaysinceFields.id: id,
        DaysinceFields.description: description,
        DaysinceFields.startDate: startDate.toIso8601String(),
      };
}
