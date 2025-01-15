import 'package:first_app/models/transaction.dart';
import 'package:first_app/widgets/chart_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> listTs;

  Chart(this.listTs);

  List<Map<String, Object>> get chartTs {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0;

      for (var i = 0; i < listTs.length; i++) {
        if (listTs[i].date.day == weekDay.day &&
            listTs[i].date.month == weekDay.month &&
            listTs[i].date.year == weekDay.year) {
          totalSum += listTs[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  int get totalSpending {
    return chartTs.fold(0, (sum, item) {
      return sum + (item['amount'] as int);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(chartTs);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: chartTs.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBox(
                  (data['day'] as String),
                  (data['amount'] as int),
                  totalSpending == 0
                      ? 0.0
                      : (data['amount'] as int) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
