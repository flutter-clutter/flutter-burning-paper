import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'example_start_screen.dart';
import 'burning_paper.dart';

void main() {
  runApp(BurningPaperApp());
}

class BurningPaperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raindrop App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
          children: <Widget>[
            Scaffold(
                appBar: AppBar(
                  title: Text('Example App'),
                ),
                body: ExampleStartScreen()
            ),
            IgnorePointer(
                child: BurningPaper()
            )
          ]
        )
    );
  }
}


