import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOTurn = true;
  List<String> gridDisplay = ['', '', '', '', '', '', '', '', ''];

  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int oScore = 0;
  int xScore = 0;
  int clickCount=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            Expanded(
              child: Container(
                  child: Center(
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player O', style: myTextStyle),
                        Text(oScore.toString(), style: myTextStyle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player X', style: myTextStyle),
                        Text(xScore.toString(), style: myTextStyle),
                      ],
                    ),
                  ),
                ]),
              )),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                        if (_checkWinner()) {
                          _showWinDialog(isOTurn);
                        }
                        else if(clickCount==9){
                          _showDrawDialog();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Text(
                            gridDisplay[index],
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Container(
              ),
            )
          ],
        ));
  }

  void _tapped(int index) {
    setState(() {
      if (gridDisplay[index] != '') return;
      if (isOTurn) {
        gridDisplay[index] = 'O';
      } else {
        gridDisplay[index] = 'X';
      }
      isOTurn = !isOTurn;
      clickCount++;
    });
  }

  bool _checkWinner() {
    if (gridDisplay[0] == gridDisplay[1] &&
        gridDisplay[0] == gridDisplay[2] &&
        gridDisplay[0] != '') {
      return true;
    }
    if (gridDisplay[3] == gridDisplay[4] &&
        gridDisplay[3] == gridDisplay[5] &&
        gridDisplay[3] != '') {
      return true;
    }
    if (gridDisplay[6] == gridDisplay[7] &&
        gridDisplay[6] == gridDisplay[8] &&
        gridDisplay[6] != '') {
      return true;
    }

    if (gridDisplay[0] == gridDisplay[3] &&
        gridDisplay[0] == gridDisplay[6] &&
        gridDisplay[0] != '') {
      return true;
    }
    if (gridDisplay[1] == gridDisplay[4] &&
        gridDisplay[1] == gridDisplay[7] &&
        gridDisplay[1] != '') {
      return true;
    }
    if (gridDisplay[2] == gridDisplay[5] &&
        gridDisplay[2] == gridDisplay[8] &&
        gridDisplay[2] != '') {
      return true;
    }

    if (gridDisplay[0] == gridDisplay[4] &&
        gridDisplay[0] == gridDisplay[8] &&
        gridDisplay[0] != '') {
      return true;
    }
    if (gridDisplay[2] == gridDisplay[4] &&
        gridDisplay[2] == gridDisplay[6] &&
        gridDisplay[2] != '') {
      return true;
    }
    return false;
  }

  void _showWinDialog(bool ohTurn) {
    String winner = ohTurn ? "X" : "O";
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner is " + winner + "!"),
            actions: [
              TextButton(
                child: Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    ohTurn ? xScore++ : oScore++;
    ohTurn = !ohTurn;
  }

  void _showDrawDialog(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Its a Draw!"),
            actions: [
              TextButton(
                child: Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        gridDisplay[i] = '';
        String value=gridDisplay[i];
        print('The value of the input is: $value');
      }
      clickCount=0;
    });
  }
}
