import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final bool isIncome;

  @HiveField(6)
  final bool isRecurring;

  Transaction({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.isIncome,
    this.isRecurring = false,
  }) : id = id ?? const Uuid().v4();

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      title: json["title"],
      amount: (json["amount"] as num).toDouble(),
      date: json["date"] is Timestamp
          ? (json["date"] as Timestamp).toDate()
          : DateTime.parse(json["date"]),
      category: json["category"],
      isIncome: json["is_income"],
      isRecurring: json["is_recurring"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "amount": amount,
      "date": date,
      "category": category,
      "is_income": isIncome,
      "is_recurring": isRecurring,
    };
  }
}
