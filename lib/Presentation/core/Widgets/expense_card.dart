import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/Core/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,

      margin: const EdgeInsets.symmetric(vertical: 6),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),

        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE0F2E9),

          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.green,
          ),
        ),

        title: Text(
          expense.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        subtitle: Text(
          '৳ ${expense.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),

        trailing: IconButton(
          onPressed: onDelete,

          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
