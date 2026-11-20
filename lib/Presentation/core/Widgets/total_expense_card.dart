
import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/Core/app_theme_color.dart';

class TotalExpenseCard extends StatelessWidget {
  final double total;

  const TotalExpenseCard({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          const Text(
            'Total Expenses',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            '৳ ${total.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
