import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;
  final List<Transaction> last4WeeksTransactions;

  Chart(this.recentTransactions, this.last4WeeksTransactions);

  List<Map<String, Object>> get groupedDailyTransactions {
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

      return  {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  // Agrupar por semanas (últimas 4 semanas)
  List<Map<String, Object>> get groupedWeeklyTransactions {
    return List.generate(4, (index) {
      final weekStart = DateTime.now().subtract(Duration(days: (index + 1) * 7));
      final weekEnd = weekStart.add(Duration(days: 6));

      double totalSum = 0.00;

      for (var tr in last4WeeksTransactions) {
        if (tr.date.isAfter(weekStart) && tr.date.isBefore(weekEnd)) {
          totalSum += tr.value;
        }
      }

      return {'week': 'Sem ${4 - index}', 'value': totalSum};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedDailyTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);  
    });
  }

  double get _monthTotalValue {
    return groupedWeeklyTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Gastos Diários',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedDailyTransactions.map((tr) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tr['day'] as String,
                    value: tr['value'] as double,
                    percentage: _weekTotalValue == 0
                        ? 0
                        : (tr['value'] as double) / _weekTotalValue,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20), // Espaço entre os gráficos
            Text(
              'Gastos Semanais',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedWeeklyTransactions.map((tr) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tr['week'] as String,
                    value: tr['value'] as double,
                    percentage: _monthTotalValue == 0
                        ? 0
                        : (tr['value'] as double) / _monthTotalValue,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}