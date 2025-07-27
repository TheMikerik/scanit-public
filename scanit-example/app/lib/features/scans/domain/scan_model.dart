import 'package:uuid/uuid.dart';

class ScanModel {
  final String id;
  final String name;
  final DateTime date;
  final bool favorite;
  final double size;
  final String mesh;
  final String metadata;
  final String? description;

  ScanModel({
    String? id,
    required this.name,
    required this.date,
    required this.favorite,
    required this.size,
    required this.mesh,
    required this.metadata,
    this.description,
  }) : id = id ?? const Uuid().v4();

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json['id'],
        name: json['name'],
        date: DateTime.parse(json['date']),
        favorite: json['favorite'],
        size: json['size'],
        mesh: json['mesh'],
        metadata: json['metadata'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'favorite': favorite,
        'size': size,
        'mesh': mesh,
        'metadata': metadata,
        'description': description,
      };

  ScanModel copyWith({
    String? id,
    String? name,
    DateTime? date,
    bool? favorite,
    double? size,
    String? mesh,
    String? metadata,
    String? description,
  }) {
    return ScanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      favorite: favorite ?? this.favorite,
      size: size ?? this.size,
      mesh: mesh ?? this.mesh,
      metadata: metadata ?? this.metadata,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'ScanModel(id: $id, name: $name, date: $date, favorite: $favorite, size: $size, mesh: $mesh, description: $description)';
  }
}
