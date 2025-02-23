import 'dart:math';

import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.blue.shade500,
          secondary: Colors.grey.shade700,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Últimos 7 dias
    Transaction(
      id: 't1',
      title: 'Mercado',
      value: 150.75,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Combustível',
      value: 220.30,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't3',
      title: 'Jantar',
      value: 85.50,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),

    // Semana 2 (7-14 dias atrás)
    Transaction(
      id: 't4',
      title: 'Academia',
      value: 90.00,
      date: DateTime.now().subtract(Duration(days: 9)),
    ),
    Transaction(
      id: 't5',
      title: 'Internet',
      value: 120.00,
      date: DateTime.now().subtract(Duration(days: 13)),
    ),

    // Semana 3 (14-21 dias atrás)
    Transaction(
      id: 't6',
      title: 'Cinema',
      value: 45.00,
      date: DateTime.now().subtract(Duration(days: 16)),
    ),
    Transaction(
      id: 't7',
      title: 'Eletrônicos',
      value: 560.00,
      date: DateTime.now().subtract(Duration(days: 20)),
    ),

    // Semana 4 (21-28 dias atrás)
    Transaction(
      id: 't8',
      title: 'Cafeteria',
      value: 30.00,
      date: DateTime.now().subtract(Duration(days: 23)),
    ),
    Transaction(
      id: 't9',
      title: 'Aluguel',
      value: 1500.00,
      date: DateTime.now().subtract(Duration(days: 27)),
    ),
  ];

  int _selectedIndex = 0; // Controla a aba ativa

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Transaction> get _last4WeeksTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 28)));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      TransactionList(_transactions, _removeTransaction),
      Chart(_recentTransactions, _last4WeeksTransactions),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: _screens[
                  _selectedIndex]), // Alterna entre Chart e TransactionList
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade800,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Gráfico',
          ),
        ],
      ),
    );
  }
}
