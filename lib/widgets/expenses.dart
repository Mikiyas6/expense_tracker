import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  void addNewExpense({title, amount, date, category}) {
    setState(() {
      _registeredExpenses.add(
        Expense(title: title, amount: amount, date: date, category: category),
      );
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addNewExpense: addNewExpense),
    );
  }

  void removeExpense(Expense expense) {
    final indexOfExpense = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 3000),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(indexOfExpense, expense);
            });
          },
        ),
        content: Text("Expense Removed"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = _registeredExpenses.isEmpty
        ? Center(child: Text("No expenses found. Start adding some!"))
        : ExpensesList(
            expenses: _registeredExpenses,
            removeExpense: removeExpense,
          );
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainWidget),
        ],
      ),
    );
  }
}
