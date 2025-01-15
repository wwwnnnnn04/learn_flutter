import 'package:first_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function(String) deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'Нет информации о финансах',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/image/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : Container(
            height: 360,
            child: ListView.builder(
              itemBuilder: (cts, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('${transaction[index].amount}'))),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(DateFormat('dd.MM.yyyy')
                        .format(transaction[index].date)),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? ElevatedButton.icon(
                            onPressed: () => deleteTx(transaction[index].id),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onError),
                            icon: Icon(Icons.delete),
                            label: Text('Удалить'))
                        : IconButton(
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () => deleteTx(transaction[index].id),
                            icon: Icon(Icons.delete),
                          ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
          );
  }
}






//  return Card(
//                   elevation: 7,
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 15,
//                           vertical: 10,
//                         ),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).colorScheme.onSurface,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Text(
//                           '${transaction[index].amount} RUB',
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transaction[index].title,
//                             style: Theme.of(context).textTheme.headlineSmall,
//                           ),
//                           Text(
//                             DateFormat('dd.MM.yyyy')
//                                 .format(transaction[index].date),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 );