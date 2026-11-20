import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/Core/database_helper.dart';
import 'package:simple_expense_tracker/Core/expense.dart';
import 'package:simple_expense_tracker/Presentation/core/Widgets/expense_card.dart';
import 'package:simple_expense_tracker/Presentation/core/Widgets/total_expense_card.dart';
import 'package:simple_expense_tracker/Presentation/feature/Expense_Page/expanse_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Expense> expenses = [];
  bool isLoading = true;

  double get totalExpenses {
    return expenses.fold(
      0.0,
          (sum, expense) => sum + expense.amount,
    );
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {

    final data = await DatabaseHelper.instance.getExpenses();

    if (!mounted) return;

    setState(() {
      expenses = data;
      isLoading = false;
    });
  }

  Future<void> deleteExpense(int id) async {
    await DatabaseHelper.instance.deleteExpense(id);
    await loadExpenses();
  }

  Future<void> openAddExpensePage() async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExpensePage(),
      ),
    );

    if (result == true) {
      await loadExpenses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalExpenseCard(
              total: totalExpenses,
            ),

            const SizedBox(height: 25),

            const Text(
              'Recent Expenses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: isLoading ? const Center(
                child: CircularProgressIndicator(),
              )
                  : expenses.isEmpty
                  ? const Center(
                child: Text(
                  'No expenses found!\nAdd your first expense.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )

                  : ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {

                  final expense = expenses[index];
                  return ExpenseCard(
                    expense: expense,
                    onDelete: () {
                      deleteExpense(expense.id!);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddExpensePage,

        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        child: const Icon(Icons.add),
      ),
    );
  }
}
