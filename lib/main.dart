import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/Core/app_theme_color.dart';
import 'Presentation/feature/Home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
