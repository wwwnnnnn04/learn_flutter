import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, int, DateTime) addNewTx;

  NewTransaction(this.addNewTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitTx() {
    if (amountController.text.isEmpty) {
      return;
    }
    final String inputTitle = titleController.text;
    final int inputAmount = int.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount < 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTx(inputTitle, inputAmount, _selectedDate!);
    Navigator.of(context).pop();
  }

  void datePick() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      ;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Наименование траты'),
                controller: titleController,
                onSubmitted: (_) => submitTx(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Сумма'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitTx(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Дата не выбрана!'
                          : 'Выбранная дата: ${DateFormat.yMd().format(_selectedDate!)}'),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: datePick,
                            child: Text(
                              'Выбрать дату',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : TextButton(
                            onPressed: datePick,
                            child: Text(
                              'Выбрать дату',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: submitTx,
                child: Text(
                  'Добавить',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
