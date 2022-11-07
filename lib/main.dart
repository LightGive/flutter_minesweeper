import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cell.dart';

const int cellWidth = 5;
const int cellHeight = 5;
const int bombNum = 5;

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
  void OpenCell(int idx) {
    var cell = cells[idx];
    if (cell.isMine) {
      _dialogBuilder(context);
      cell.Open();
      return;
    }

    print('$idxをを開いた');
  }

  @override
  void initState() {
    super.initState();
    generateCell();
    SetBomb();
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

  void SetBomb() {
    // 設定する爆弾の数が正しいか
    assert(0 < bombNum && bombNum < cellWidth * cellHeight);
    for (var i = 0; i < bombNum; i++) {
      bool setMine = false;
      while (!setMine) {
        var ran = math.Random().nextInt(cells.length);
        var cell = cells[ran];
        if (cell.isMine) {
          continue;
        }
        cell.SetMine(true);
        SetAroundCell(ran);
        setMine = true;
      }
    }
  }

  void SetAroundCell(int idx) {
    var isTop = IsAroundTop(idx);
    var isBottom = IsAroundBottom(idx);
    var isRight = IsAroundRight(idx);
    var isLeft = IsAroundLeft(idx);
    if (!isTop) {
      cells[idx - cellWidth].SetBombCount();
    }
    if (!isBottom) {
      cells[idx + cellWidth].SetBombCount();
    }
    if (!isRight) {
      cells[idx + 1].SetBombCount();
    }
    if (!isLeft) {
      cells[idx - 1].SetBombCount();
    }
    if (!isTop && !isLeft) {
      cells[idx - cellWidth - 1].SetBombCount();
    }
    if (!isTop && !isRight) {
      cells[idx - cellWidth + 1].SetBombCount();
    }
    if (!isBottom && !isLeft) {
      cells[idx + cellWidth - 1].SetBombCount();
    }
    if (!isBottom && !isRight) {
      cells[idx + cellWidth + 1].SetBombCount();
    }
  }

  bool IsAroundTop(idx) => idx < cellWidth;
  bool IsAroundBottom(idx) => (cells.length - cellWidth) <= idx;
  bool IsAroundLeft(idx) => idx % cellWidth == 0;
  bool IsAroundRight(idx) => (idx + 1) % cellWidth == 0;

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
    var cell = cells[index];
    if (cell.isOpen) {
      return IconButton(onPressed: null, icon: const Icon(Icons.volume_up));
    } else {
      var count = cells[index].aroundMineCnt;
      return ElevatedButton(
        onPressed: () => OpenCell(index),
        child: Text('$count'),
        style: ElevatedButton.styleFrom(primary: Colors.purple),
      );
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GameOver'),
          content: const Text('どかーん'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
