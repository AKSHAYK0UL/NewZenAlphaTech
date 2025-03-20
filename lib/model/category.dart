import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  Category({
    String? id,
    required this.name,
  }) : id = id ?? const Uuid().v4();
}
