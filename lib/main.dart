import 'package:despesas_pessoais/components/transaction_user.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());


class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Expenses"),
      ),
      body: Column(
        crossAxisAlignment:  CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text("Grafico"),
            ),
          ),
          TransactionUser()
        ],
      )
    );
  }
}