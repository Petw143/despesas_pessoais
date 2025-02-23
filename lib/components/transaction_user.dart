import 'dart:math';

import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  
  final _transactions = [
    Transaction(id: "t1", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t2", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t3", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t4", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t5", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t6", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t7", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t8", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t9", title: "Tenis de corrida", value: 315.99, date: DateTime.now()),
    Transaction(id: "t10", title: "Conta de luz", value: 215.77, date: DateTime.now())
  ];

  void _addTransaction(String title, double value) {
    final Transaction newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now()
    );
  
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionForm(_addTransaction),
        TransactionList(_transactions)
      ],
    );
  }
}