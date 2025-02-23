import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.00;

      for(var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day; 
        bool sameMonth = recentTransactions[i].date.month == weekDay.month; 
        bool sameYear = recentTransactions[i].date.year == weekDay.year; 

        if(sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum)

      return  {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child:Row(
        children: <Widget>[

        ],
      )
    );
  }
}