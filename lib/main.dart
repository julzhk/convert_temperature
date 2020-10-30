import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gas Mark Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List convert(int e) {
  // faranheit, centegrade, centegrade-fan-oven, start-col, end-colour
  Map temps = {
    1: [275, 135, 125, 0xffadb4ec],
    2: [300, 150, 140, 0xffb5a5dc],
    3: [325, 165, 150, 0xffbc98cd],
    4: [350, 180, 160, 0xffc28cc0],
    5: [375, 190, 170, 0xffca7cae],
    6: [400, 205, 185, 0xffd070a1],
    7: [425, 220, 200, 0xffd66494],
    8: [450, 230, 210, 0xffde5584],
    9: [475, 245, 225, 0xffe74371],
    10: [500, 260, 240, 0xffef335f],
    11: [500, 260, 240, 0xfff91f1f],
    12: [500, 260, 240, 0xfff91f1f],
  };
  return temps[e];
}

List<Color> colourGradient(int e) {
  int start = convert(e)[3];
  int end = convert(e + 2)[3];
  return [
    Color(start),
    Color(end),
  ];
}

class _MyHomePageState extends State<MyHomePage> {
  int _progress = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: colourGradient(_progress)[1],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: colourGradient(_progress))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(
                'Gas Mark',
              ),
              Text(
                '$_progress',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                '${convert(_progress)[1]}°C',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                '${convert(_progress)[0]}°F',
                style: Theme.of(context).textTheme.headline3,
              ),
              Spacer(),
              CupertinoSlider(
                value: _progress.toDouble(),
                min: 1.0,
                max: 10.0,
                activeColor: Colors.white,
                thumbColor: Colors.blue,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _progress = value.toInt();
                  });
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
