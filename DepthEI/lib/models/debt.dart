class DebtItem {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  final String status; // pending | paid
  final int priority; // 1-5

  const DebtItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.priority,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'amount': amount,
        'due_date': dueDate.toIso8601String(),
        'status': status,
        'priority': priority,
      };

  factory DebtItem.fromMap(String id, Map<String, dynamic> map) => DebtItem(
        id: id,
        title: (map['title'] ?? '') as String,
        amount: (map['amount'] ?? 0).toDouble(),
        dueDate: DateTime.tryParse((map['due_date'] ?? '') as String) ?? DateTime.now(),
        status: (map['status'] ?? 'pending') as String,
        priority: (map['priority'] ?? 3) as int,
      );
}
