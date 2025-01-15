// ignore_for_file: prefer_const_constructors, unnecessary_set_literal, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:first_app/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
import './widgets/transaction_list.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme lightColorScheme = ColorScheme.light(
      primary: Color(0xFFEA55B8), // Основной розовый цвет
      onPrimary: Color(0xFFFFFFFF), // Текст на кнопках/иконках с primary
      secondary: Color(0xFFF7BEE4), // Второстепенный (для акцентов)
      onSecondary: Color(0xFF5A1047), // Текст на элементах с secondary
      background: Color(0xFFFDEBF7), // Фон приложения
      onBackground: Color(0xFF5A1047), // Текст на фоне
      surface: Color(0xFFFAD5ED), // Цвет карточек, кнопок, элементов UI
      onSurface: Color(0xFF5A1047), // Текст на surface
      error: Color(0xFFD32F2F), // Цвет для ошибок
      onError: Color(0xFFFFFFFF), // Текст/иконки на error
    );

    final ColorScheme darkColorScheme = ColorScheme.dark(
      primary: Color(0xFFEA55B8), // Основной розовый цвет
      onPrimary: Color(0xFF121212), // Текст на primary (обратный контраст)
      secondary: Color(0xFFF7BEE4), // Второстепенный цвет
      onSecondary: Color(0xFF28051C), // Текст на secondary
      background: Color(0xFF121212), // Тёмный фон приложения
      onBackground: Color(0xFFFAD5ED), // Текст на фоне
      surface: Color(0xFF1F1F1F), // Тёмные карточки и элементы UI
      onSurface: Color(0xFFF7BEE4), // Текст на surface
      error: Color(0xFFD32F2F), // Цвет для ошибок
      onError: Color(0xFFFFFFFF), // Текст/иконки на error
    );
    final ThemeData lightTheme = ThemeData(
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: lightColorScheme.background,
      fontFamily: 'Quicksand',
      textTheme: TextTheme(
          headlineSmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans')),
      appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          titleTextStyle: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightColorScheme.secondary,
        foregroundColor: lightColorScheme.onSecondary,
      ),
    );

    final ThemeData darkTheme = ThemeData(
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.secondary,
        foregroundColor: darkColorScheme.onSecondary,
      ),
    );
    return MaterialApp(
      title: 'Flutter App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: MyClass(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  final List<Transaction> transaction = [];

  void _addNewTx(String title, int amount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      transaction.add(newTx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      return transaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTx),
          );
        });
  }

  bool _showChart = false;

  List<Transaction> get _listTx {
    return transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cupertinoAppBar = CupertinoNavigationBar(
      middle: Text(
        'Управляем финансами',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTx(context),
          )
        ],
      ),
    );
    final appBar = AppBar(
      title: Text(
        'Управляем финансами',
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => _startAddNewTx(context),
        ),
      ],
    );
    final media = MediaQuery.of(context);
    final isOrient = media.orientation == Orientation.landscape;

    final txList = Container(
        height: (media.size.height -
                appBar.preferredSize.height -
                media.padding.top) *
            0.68,
        child: TransactionList(transaction, _deleteTx));
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isOrient)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Показать график'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isOrient)
              Container(
                  width: double.infinity,
                  height: (media.size.height -
                          appBar.preferredSize.height -
                          media.padding.top) *
                      0.32,
                  child: Chart(_listTx)),
            if (!isOrient) txList,
            if (isOrient)
              _showChart
                  ? Container(
                      width: double.infinity,
                      height: (media.size.height -
                              appBar.preferredSize.height -
                              media.padding.top) *
                          0.68,
                      child: Chart(_listTx),
                    )
                  : txList
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: cupertinoAppBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                ),
                onPressed: () => _startAddNewTx(context)),
          );
  }
}
