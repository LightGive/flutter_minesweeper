import 'package:flutter/material.dart';

import 'cell.dart';

const int cellWidth = 5;
const int cellHeight = 5;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Mine Sweeper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var cells = [];

  // ボタンを押したときの処理
  void OnButtonDownCell(int idx) {
    cells[idx].Open();
    print('$idxをを開いた');
  }

  @override
  void initState() {
    super.initState();
    generateCell();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: buildCell(),
      ),
    );
  }

  void generateCell() {
    for (var i = 0; i < cellWidth; i++) {
      for (var j = 0; j < cellHeight; j++) {
        cells.add(cell(false, false, 0));
      }
    }
  }

  GridView buildCell() {
    return GridView.count(
      mainAxisSpacing: 5,
      crossAxisSpacing: 10,
      crossAxisCount: cellWidth,
      children: List.generate(
        cells.length,
        (index) => buildButton(index),
      ),
    );
  }

  Widget buildButton(int index) {
    return ElevatedButton(
      onPressed: () => OnButtonDownCell(index),
      child: Text('a'),
      style: ElevatedButton.styleFrom(primary: Colors.purple),
    );
  }
}
